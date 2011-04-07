require 'spec_helper'

describe 'CreditCards' do
  
  describe 'GET /credit_cards' do
    before(:each) do
       plan = Factory(:plan, :name => "Gold", :price => 20)
       contact_info = Factory(:contact_info)
       subscription = Factory(:subscription, :plan => plan)
       credit_card = Factory(:credit_card)
       @account = Factory(:account, :contact_info => contact_info, :subscription => subscription, :credit_card => credit_card)
    end
    
    it 'should load credit_card path' do
      visit account_credit_cards_path(@account)
      page.should have_content(@account.credit_card.card_number)
      page.should have_content(@account.credit_card.expiration_date)
    end
    
  end
  
  
end