require 'spec_helper'

describe 'BillingHistory' do
  
  describe 'GET /index' do
    before(:each) do
      @billing_activity1 = Factory(:billing_activity, :amount => 13.00, :message => "Thanks for your payment." )
      @billing_activity2 = Factory(:billing_activity, :amount => 18.00, :message => "Thanks for your payment." )
      @plan = Factory.build(:plan, :name => "Gold", :price => 20)
      @contact_info = Factory.build(:contact_info)
      @subscription = Factory.build(:subscription, :plan => @plan)
      @credit_card = Factory.build(:credit_card)
      @account = Factory(:account, :contact_info => @contact_info, :subscription => @subscription, :credit_card => @credit_card)
      @user = Factory(:user, :account => @account)
      @account.billing_activities << @billing_activity1
      @account.billing_activities << @billing_activity2
    end
    
    it 'should load billing histories page' do
      visit account_billing_history_path
      page.should have_content "18.00"
      page.should have_content "Thanks for your payment."
    end
  end
  
end