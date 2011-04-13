require 'spec_helper'

describe BillingActivity do
  it { should belong_to :subscription }
  it { should have_one :invoice }
  
  describe 'on charge' do
    before(:each) do
       plan = Factory.build(:plan, :name => "Gold", :price => 20)
       contact_info = Factory.build(:contact_info)
  
       credit_card = Factory.build(:credit_card)
       @subscription = Factory(:subscription, :contact_info => contact_info, :plan => plan, :credit_card => credit_card)
    end
    
    it 'should create a new billing activity on successful charge' do
      @subscription.bill!
      @subscription.billing_activities.count.should == 2
    
    end
    
    it 'should create link to invoice in message if it has an invoice' do
      @subscription.invoice!
      @subscription.billing_activities.last.message.should include "<a href"
    end
  end
end