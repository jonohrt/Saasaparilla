require 'spec_helper'

describe BillingActivity do
  it { should belong_to :account }
  it { should have_one :invoice }
  
  describe 'on charge' do
    before(:each) do
       plan = Factory(:plan, :name => "Gold", :price => 20)
       contact_info = Factory(:contact_info)
       subscription = Factory(:subscription, :plan => plan)
       credit_card = Factory(:credit_card)
       @account = Factory(:account, :contact_info => contact_info, :subscription => subscription, :credit_card => credit_card)
    end
    
    it 'should create a new billing activity on successful charge' do
      @account.bill!
      @account.billing_activities.count.should == 1
    
    end
  end
end