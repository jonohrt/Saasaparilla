require 'spec_helper'

describe 'BillingHistory' do
  
  describe 'GET /index' do
    before(:each) do
      @billing_activity1 = Factory(:billing_activity, :amount => 13.00, :message => "Thanks for your payment." )
      @billing_activity2 = Factory(:billing_activity, :amount => 18.00, :message => "Thanks for your payment." )
      @plan = Factory.build(:plan, :name => "Gold", :price => 20)
      @contact_info = Factory.build(:contact_info)

      @credit_card = Factory.build(:credit_card)
      @subscription = Factory(:subscription, :contact_info => @contact_info, :plan => @plan, :credit_card => @credit_card)
      @user = Factory(:user, :subscription => @subscription)
      @subscription.billing_activities << @billing_activity1
      @subscription.billing_activities << @billing_activity2
    end
    
    it 'should load billing histories page' do
    
      visit subscription_billing_history_path
      page.should have_content "18.00"
      page.should have_content "Thanks for your payment."
    end
  end
  
end