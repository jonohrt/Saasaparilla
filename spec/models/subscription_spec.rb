require 'spec_helper'

describe Subscription do
  
  it { should have_one :contact_info }
  it { should have_many :billing_activities }
  it { should have_one :credit_card }
  
  
  

  
  describe 'on create' do
    before(:each) do
       plan = Factory.build(:plan, :name => "Gold", :price => 20.0)
       contact_info = Factory.build(:contact_info)
     
       credit_card = Factory.build(:credit_card)
       @subscription = Factory.build(:subscription, :contact_info => contact_info, :plan => plan, :credit_card => credit_card)
    end
    
    it 'should make parent billable if is_billable' do
     
      user = Factory.create(:user, :subscription => @subscription)
      user.billable?
      user.subscription.billable.should == user
    end
    
    it 'should add cim number on create' do
        @subscription.save
        @subscription.customer_cim_id.should_not be_nil
    end
    
    it 'should create payment profile after create' do
       @subscription.save
       @subscription.customer_payment_profile_id.should_not == nil
    end
    
    # it 'should have an inital balance' do
    #   @subscription.should_receive(:balance=).with(20.0)
    #   @subscription.save
    # end
  
    it 'should send subscription_created email' do
      Saasaparilla::Notifier.should_receive(:subscription_created).with(@subscription)
      @subscription.save
    end
  
    it 'should have status active' do
       @subscription.save
       @subscription.active?.should == true
    end
    
    
    it 'should have status of active after successful billing' do
      @subscription.save
      @subscription.stub!(:charge_amount).with(@subscription.balance).and_return true
      
      @subscription.bill!
      @subscription.active?.should == true
    end
    
    it 'should have status of overdue after unsuccessful billing' do
      #Pending
      # @subscription.save
      # @subscription.stub!(:charge_amount).with(@subscription.balance).and_return false
      # 
      # @subscription.do_inital_billing
      # @subscription.overdue?.should == true
    end
    
    it 'should return set subscription balance to 0 on successful charge' do
       @subscription.save
       @subscription.bill!
       @subscription.balance.should == 0
       
    end
    
    it 'should keep status at :ok on successful charge' do
       @subscription.save
       @subscription.bill!
       @subscription.active?.should == true
       
    end
    
    it 'should charge an inital balance' do
      @subscription.should_receive(:charge_amount).with(20.0)
      @subscription.save
    end
    
    it 'should have an billing activity after inital charge' do
      @subscription.save
      @subscription.billing_activities.count.should == 1
    end
    
    it 'should set billing date after inital charge' do
      @subscription.save
      @subscription.billing_date.should == Date.today + 1.months
    end
    
    it 'should create a billing activity on charge' do
      @subscription.save
      @subscription.billing_activities.count.should == 1
      @subscription.update_attributes(:balance => 30.0)
      @subscription.bill!(30.00)
      @subscription.billing_activities.count.should == 2
    end
    
    it 'should send billing_successful email on charge' do
      @subscription.save
      @subscription.update_attributes(:balance => 30.0)
      Saasaparilla::Notifier.should_receive(:billing_successful).with(@subscription, 30.0)
      @subscription.bill!
    end
    
    it 'should subtract balance on bill!' do
      @subscription.save
      @subscription.billing_activities.count.should == 1
      @subscription.update_attributes(:balance => 30.0)
      @subscription.bill!(10.00)
      @subscription.balance.should == 20.0
    end
    it 'should not change status if oustanding balance not paid' do
      @subscription.save
      @subscription.billing_activities.count.should == 1
      @subscription.update_attributes(:balance => 30.0, :status => "overdue")
      @subscription.bill!(10.00)
      @subscription.status.should == "overdue"
      
    end
    it 'should change status if oustanding balancepaid' do
      @subscription.save
      @subscription.billing_activities.count.should == 1
      @subscription.update_attributes(:balance => 30.0, :status => "overdue")
      @subscription.bill!(30.00)
      @subscription.status.should == "active"
      
    end
    
    it 'should set cancel status to pending_cancel' do
      @subscription.save
      @subscription.cancel
      @subscription.status.should == "canceled"
   
    end
    

    
    
  end
  
  describe 'billing' do
      before(:each) do
          plan = Factory(:plan, :name => "Gold", :price => 20.0)
          plan2 = Factory(:plan, :name => "Gold", :price => 20.0, :billing_period => "annually")
          contact_info = Factory.build(:contact_info)
          credit_card = Factory.build(:credit_card)
          @subscription1 = Factory(:subscription, :contact_info => contact_info,  :plan => plan, :credit_card => credit_card)
          @subscription2 = Factory(:subscription, :contact_info => contact_info,  :plan => plan, :credit_card => credit_card)
          @subscription3 = Factory(:subscription, :contact_info => contact_info,  :plan => plan, :credit_card => credit_card)
          @subscription4 = Factory(:subscription, :contact_info => contact_info,  :plan => plan2, :credit_card => credit_card)
          @subscription1.update_attributes(:balance => 12, :billing_date => Date.today)
          @subscription2.update_attributes(:balance => 12, :billing_date => Date.today)
          @subscription3.update_attributes(:balance => 12, :billing_date => Date.today + 1.days)
          @subscription4.update_attributes(:balance => 12, :billing_date => Date.today - 1.days)
      end
      
      it 'should find all non canceled subscriptions' do
        @subscription2.cancel
        Subscription.active.count.should == 3
      end
      it 'should find billable models' do
        

        Subscription.active.all_billable_subscriptions(Date.today).count.should == 3
      end
      
      it 'should find invoiceable models' do
      
        @subscription1.update_attributes(:billing_date => (Date.today + 1.days))
        @subscription2.update_attributes(:billing_date => (Date.today + 6.days))
        @subscription3.update_attributes(:billing_date => (Date.today + 5.days), :invoiced_on => Date.today - 1.months)
        @subscription4.update_attributes(:billing_date => (Date.today + 5.days), :invoiced_on => Date.today - 2.days)
        @subscriptions = Subscription.active.all_invoiceable(Date.today)
        @subscriptions.count.should == 2
        @subscriptions.should include @subscription1
        @subscriptions.should include @subscription4
        
      end

      it 'should find billable models' do
        @subscription1.update_attributes(:balance => 0)

        @subscription4.update_attributes(:balance => 12, :status => "canceled")
        Subscription.active.all_billable_subscriptions(Date.today).count.should == 1
      end

    describe 'recurring billing' do
    
      it 'should reset charge subscription' do
        Subscription.find_and_bill_recurring_subscriptions
        @subscription1.billing_activities.count.should == 2
        @subscription2.billing_activities.count.should == 2
        @subscription3.billing_activities.count.should == 1
        @subscription4.billing_activities.count.should == 2
      end

      it 'should change status of subscription to overdue if failed billing' do
        GATEWAYCIM.success = false
        Subscription.find_and_bill_recurring_subscriptions
        GATEWAYCIM.success = true
        @subscription1.reload.overdue?.should == true
      end

      # it 'should send billing_failed email if failed billing' do
      #   GATEWAYCIM.success = false
      #   Saasaparilla::Notifier.should_receive(:billing_failed).with(@subscription1)
      #   Subscription.find_and_bill_recurring_subscriptions
      #   GATEWAYCIM.success = true
      # end

      it 'should change status of subscription to canceled if failed over grace period' do
        @subscription1.update_attributes(:billing_date => Date.today - 11.days, :status => "overdue")
        GATEWAYCIM.success = false
        Subscription.find_and_bill_recurring_subscriptions
        GATEWAYCIM.success = true
        @subscription1.reload.canceled?.should == true
      end
      
      it 'should not change status if subscription not past grace period on failed billing' do
        @subscription2.update_attributes(:billing_date => Date.today - 9.days, :status => "overdue", :overdue_on => Date.today - 9.days)
        GATEWAYCIM.success = false
        Subscription.find_and_bill_recurring_subscriptions
        GATEWAYCIM.success = true
        @subscription2.reload.overdue?.should == true
      end
      
      it 'should set overdue_on to todays date when payment failed' do
        @subscription1.update_attributes(:billing_date => Date.today , :status => "active")
        GATEWAYCIM.success = false
        Subscription.find_and_bill_recurring_subscriptions
        GATEWAYCIM.success = true
        @subscription1.reload.overdue?.should == true
        @subscription1.overdue_on.should == Date.today
      end
      it 'should set billing date to next month' do
        @billing_date1_old = @subscription1.billing_date
        @billing_date2_old = @subscription2.billing_date
        @billing_date4_old = @subscription4.billing_date
        Subscription.find_and_bill_recurring_subscriptions
        @subscription1.reload.billing_date.should == @billing_date1_old + 1.months
        @subscription2.reload.billing_date.should == @billing_date2_old + 1.months
        @subscription4.reload.billing_date.should == @billing_date4_old + 1.years
      end
      
      it 'should set balance on invoice' do
        @subscription1.balance.should == 12.0
        @subscription1.invoice!
        @subscription1.reload
        @subscription1.balance.should == 32.0
      end
      it 'should create invoice on invoice' do
        @subscription1.invoice!
        
        @subscription1.billing_activities.last.invoice.should_not == nil
      end
      
      it 'should get amount on invoice after create invoice' do
        @subscription1.invoice!
        @subscription1.billing_activities.last.invoice.amount.should == 20.0
      end
      it 'should set invoiced_on after invoice' do
        @subscription1.invoice!
        @subscription1.invoiced_on.should == Date.today
      end
      
      it 'should set to and from date on invoice after invoice' do
        @subscription1.invoice!
        @subscription1.billing_activities.last.invoice.invoice_line_items.first.to.should == @subscription1.billing_date
      end
      
    end
  end
  


    
  
  

end