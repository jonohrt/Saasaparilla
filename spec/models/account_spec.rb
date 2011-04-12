require 'spec_helper'

describe Account do
  
  it { should have_one :contact_info }
  it { should have_many :billing_activities }
  it { should have_one :credit_card }
  
  
  

  
  describe 'on create' do
    before(:each) do
       plan = Factory.build(:plan, :name => "Gold", :price => 20.0)
       contact_info = Factory.build(:contact_info)
       subscription = Factory.build(:subscription, :plan => plan)
       credit_card = Factory.build(:credit_card)
       @account = Factory.build(:account, :contact_info => contact_info, :subscription => subscription, :credit_card => credit_card)
    end
    
    it 'should make parent billable if is_billable' do
     
      user = Factory.create(:user, :account => @account)
      user.billable?
      user.account.billable.should == user
    end
    
    it 'should add cim number on create' do
        @account.save
        @account.customer_cim_id.should_not be_nil
    end
    
    it 'should create payment profile after create' do
       @account.save
       @account.customer_payment_profile_id.should_not == nil
    end
    
    # it 'should have an inital balance' do
    #   @account.should_receive(:balance=).with(20.0)
    #   @account.save
    # end
  
    it 'should have status ok' do
       @account.save
       @account.ok?.should == true
    end
    
    
    it 'should have status of ok after successful billing' do
      @account.save
      @account.stub!(:charge_amount).with(@account.balance).and_return true
      
      @account.bill!
      @account.ok?.should == true
    end
    
    it 'should have status of overdue after unsuccessful billing' do
      #Pending
      # @account.save
      # @account.stub!(:charge_amount).with(@account.balance).and_return false
      # 
      # @account.do_inital_billing
      # @account.overdue?.should == true
    end
    
    it 'should return set account balance to 0 on successful charge' do
       @account.save
       @account.bill!
       @account.balance.should == 0
       
    end
    
    it 'should keep status at :ok on successful charge' do
       @account.save
       @account.bill!
       @account.ok?.should == true
       
    end
    
    it 'should charge an inital balance' do
      @account.should_receive(:charge_amount).with(20.0)
      @account.save
    end
    
    it 'should have an billing activity after inital charge' do
      @account.save
      @account.billing_activities.count.should == 1
    end
    
    it 'should create a billing activity on charge' do
      @account.save
      @account.billing_activities.count.should == 1
      @account.update_attributes(:balance => 30.0)
      @account.bill!(30.00)
      @account.billing_activities.count.should == 2
      
    end
    it 'should subtract balance on bill!' do
      @account.save
      @account.billing_activities.count.should == 1
      @account.update_attributes(:balance => 30.0)
      @account.bill!(10.00)
      @account.balance.should == 20.0
    end
    it 'should not change status if oustanding balance not paid' do
      @account.save
      @account.billing_activities.count.should == 1
      @account.update_attributes(:balance => 30.0, :status => "overdue")
      @account.bill!(10.00)
      @account.status.should == "overdue"
      
    end
    it 'should change status if oustanding balancepaid' do
      @account.save
      @account.billing_activities.count.should == 1
      @account.update_attributes(:balance => 30.0, :status => "overdue")
      @account.bill!(30.00)
      @account.status.should == "ok"
      
    end
    
    it 'should set cancel status to pending_cancel' do
      @account.save
      @account.cancel
      @account.status.should == "canceled"
   
    end
    
    it 'should set billing date to next date on do recurring billing'
    
  end
  
  describe 'billing' do
      before(:each) do
          plan = Factory(:plan, :name => "Gold", :price => 20.0)
          plan2 = Factory(:plan, :name => "Gold", :price => 20.0, :billing_period => "yearly")
          contact_info = Factory.build(:contact_info)
          credit_card = Factory.build(:credit_card)
          @account1 = Factory(:account, :contact_info => contact_info, :subscription => Factory(:subscription, :plan => plan), :credit_card => credit_card, :billing_date => Date.today)
          @account2 = Factory(:account, :contact_info => contact_info, :subscription => Factory(:subscription, :plan => plan), :credit_card => credit_card, :billing_date => Date.today)
          @account3 = Factory(:account, :contact_info => contact_info, :subscription => Factory(:subscription, :plan => plan), :credit_card => credit_card, :billing_date => Date.today + 1.days)
          @account4 = Factory(:account, :contact_info => contact_info, :subscription => Factory(:subscription, :plan => plan2), :credit_card => credit_card, :billing_date => Date.today - 1.days)
          @account1.update_attributes(:balance => 12)
          @account2.update_attributes(:balance => 12)
          @account3.update_attributes(:balance => 12)
          @account4.update_attributes(:balance => 12)
      end
      
      it 'should find all non canceled accounts' do
        @account2.cancel
        Account.active.count.should == 3
      end
      it 'should find billable models' do
        @account1.update_attributes(:balance => 12)
        @account2.update_attributes(:balance => 12)
        @account3.update_attributes(:balance => 12)
        @account4.update_attributes(:balance => 12)
        Account.active.all_billable_accounts(Date.today).count.should == 3
      end
      it 'should find billable models' do
        @account1.update_attributes(:balance => 0)
        @account2.update_attributes(:balance => 12)
        @account3.update_attributes(:balance => 12)
        @account4.update_attributes(:balance => 12, :status => "canceled")
        Account.active.all_billable_accounts(Date.today).count.should == 1
      end
    describe 'recurring billing' do
    
      it 'should reset charge account' do
        Account.find_and_bill_recurring_accounts
        @account1.billing_activities.count.should == 2
        @account2.billing_activities.count.should == 2
        @account3.billing_activities.count.should == 1
        @account4.billing_activities.count.should == 2
        
        
      end
      it 'should set billing date to next month' do
        Account.find_and_bill_recurring_accounts
        @account1.billing_date.should == Date.today + 1.months
        @account2.billing_date.should == Date.today + 1.months
        @account4.billing_date.should == Date.today + 1.years
      end
      
    end
  end
  


    
  
  

end