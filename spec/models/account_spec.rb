require 'spec_helper'

describe Account do
  
  it { should have_one :contact_info }
  it { should have_many :billing_activities }
  it { should have_one :credit_card }
  
  
  

  
  describe 'on create' do
    before(:each) do
       plan = Factory(:plan, :name => "Gold", :price => 20)
       contact_info = Factory(:contact_info)
       subscription = Factory(:subscription, :plan => plan)
       credit_card = Factory(:credit_card)
       @account = Factory(:account, :contact_info => contact_info, :subscription => subscription, :credit_card => credit_card)
    end
    
    it 'should make parent billable if is_billable' do
     
      user = Factory(:user, :account => @account)
      user.billable?
      user.account.billable.should == user
    end
    
    it 'should add cim number on create' do

        @account.customer_cim_id.should_not be_nil
    end
    
    it 'should create payment profile after create' do
    
       @account.customer_payment_profile_id.should_not == nil
    end
    
    it 'should have an inital ballance' do
   
      @account.balance.should == 20
    end
  
    it 'should have status ok' do
       @account.ok?.should == true
    end
    
    
    it 'should have status of ok after successful billing' do
      @account.stub!(:charge_amount).with(@account.balance).and_return true
      @account.bill!
      @account.ok?.should == true
    end
    
    it 'should have status of overdue after unsuccessful billing' do
      @account.stub!(:charge_amount).with(@account.balance).and_return false
      @account.bill!
      @account.overdue?.should == true
    end
    
    it 'should return set account balance to 0 on successful charge' do
       @account.bill!
       @account.balance.should == 0
       
    end
    
    it 'should keep status at :ok on successful charge' do
       @account.bill!
       @account.ok?.should == true
       
    end
    
  end
  


    
  
  

end