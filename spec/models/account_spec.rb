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
      
      @account.do_inital_billing
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
       @account.do_inital_billing
       @account.balance.should == 0
       
    end
    
    it 'should keep status at :ok on successful charge' do
       @account.save
       @account.do_inital_billing
       @account.ok?.should == true
       
    end
    
    it 'should charge an inital balance' do
      @account.should_receive(:charge_amount).with(20.0)
      @account.save
    end
   
   
    
  end
  


    
  
  

end