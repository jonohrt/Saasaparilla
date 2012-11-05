require 'spec_helper'

describe 'CreditCard' do
  
  describe 'GET /credit_card' do
    before(:each) do
      
       @plan = Factory.build(:plan, :name => "Gold", :price => 20)
       @contact_info = Factory.build(:contact_info)
     
       @credit_card = Factory.build(:credit_card)
       @subscription = Factory(:subscription, :contact_info => @contact_info, :plan => @plan, :credit_card => @credit_card)
       @user = Factory(:user, :subscription => @subscription)
    end
    
    it 'should load credit_card path' do
      visit edit_subscription_credit_card_path
      page.should have_content(@subscription.credit_card.card_number)
      page.should have_content(@subscription.credit_card.expiration_date)
    end
    
  end
  
  describe 'POST /credit_cards' do
    before(:each) do
      @plan = Factory.build(:plan, :name => "Gold", :price => 20)
      @contact_info = Factory.build(:contact_info)

      @credit_card = Factory.build(:credit_card)
      @subscription = Factory(:subscription, :contact_info => @contact_info, :plan => @plan, :credit_card => @credit_card)
       @user = Factory(:user, :subscription => @subscription)
    end
    it 'should update credit card' do
      visit edit_subscription_credit_card_path
      # fill_in "First name", :with => "Bob"
      # fill_in "Last name", :with => "Herman"
      fill_in "Card number", :with => "4111111111111111"
      select 'Visa', :from => "Card type"
      fill_in "Card verification", :with => "332"
      select '12', :from => "Expiry month"
      select (Date.today.year + 1).to_s, :from => "Expiry year"
    
      click_on("Update Card")
      page.should have_content("Your credit card was successfully updated.")
      page.should have_content("12/#{(Date.today.year + 1).to_s}")
    end
    
    it 'should update credit card' do
      GATEWAYCIM.success= false
      visit edit_subscription_credit_card_path
      # fill_in "First name", :with => "Bob"
      # fill_in "Last name", :with => "Herman"
      fill_in "Card number", :with => "4111111111111111"
      select 'Visa', :from => "Card type"
      fill_in "Card verification", :with => "332"
      select '12', :from => "Expiry month"
      select (Date.today.year + 1).to_s, :from => "Expiry year"
    
      click_on("Update Card")
      page.should have_content("The transaction was unsuccessful.")
      GATEWAYCIM.success= true
    end
    
    it 'should keep current card the same om error' do
      visit edit_subscription_credit_card_path
      
      fill_in "Card number", :with => "425656956545454"
      select 'Visa', :from => "Card type"
      select '12', :from => "Expiry month"
      select (Date.today.year + 1).to_s, :from => "Expiry year"
      click_on("Update Card")
      page.should have_content("XXXXXXXXXXXX1111")
      page.should have_content("10/#{(Date.today.year + 1)}")
    end
    
  end
    
  
end