require 'spec_helper'

describe "Invoices" do
  describe 'GET /invoices/:id' do
    before(:each) do
      @plan = Factory.build(:plan, :name => "Gold", :price => 20)
      @contact_info = Factory.build(:contact_info)
      @subscription = Factory.build(:subscription, :plan => @plan)
      @credit_card = Factory.build(:credit_card)
      @account = Factory(:account, :contact_info => @contact_info, :subscription => @subscription, :credit_card => @credit_card)
      @user = Factory(:user, :account => @account)
      @account.invoice!
    
    end
    it 'should show invoice'
    # do
    #  visit account_billing_history_path
    #  click_on "Invoice"
    #  page.should have_content("Invoice")
    # end
    
    
  end
  
  
  
  
end