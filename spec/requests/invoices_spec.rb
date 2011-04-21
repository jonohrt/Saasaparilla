require 'spec_helper'

describe "Invoices" do
  describe 'GET /invoices/:id' do
    before(:each) do
      @plan = Factory.build(:plan, :name => "Gold", :price => 20)
      @contact_info = Factory.build(:contact_info)
  
      @credit_card = Factory.build(:credit_card)
      @subscription = Factory(:subscription, :contact_info => @contact_info, :plan => @plan, :credit_card => @credit_card)
      @user = Factory(:user, :subscription => @subscription)
      @subscription.invoice!
    
    end
  
    
    
  end
  
  
  
  
end