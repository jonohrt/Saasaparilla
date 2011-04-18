require 'spec_helper'

describe 'Subscriptions' do
  
  describe 'Post /subscription' do
    before(:each) do
      Factory.create(:user)
      Factory.create(:plan, :name => "Gold", :price => 4.00)
      Factory.create(:plan, :name => "Silver")
    end
    it "should create a new subscription" do
      visit new_subscription_path
      fill_in "subscription_contact_info_attributes_first_name", :with => "Bob"
      fill_in "subscription_contact_info_attributes_last_name", :with => "Jones"
      fill_in "Email", :with => "bobjones@123.com"
      fill_in "Address", :with => "123 fake st"
      fill_in "City", :with => "seattle"
      fill_in "State", :with => "wa"
      fill_in "Zip", :with => "98123"
      select 'United States', :from => 'Country'
      fill_in "subscription_contact_info_attributes_phone_area_code", :with => "206"
      fill_in "subscription_contact_info_attributes_phone_prefix", :with => "123"
      fill_in "subscription_contact_info_attributes_phone_suffix", :with => "1234"
      fill_in "Card number", :with => "4111111111111111"
      select 'Visa', :from => "Card type"
      fill_in "Card verification", :with => "332"
      select '10', :from => "Expiry month"
      select Date.today.year.to_s, :from => "Expiry year"
      choose 'Gold'
      click_on 'Create Subscription'
      page.should have_content("Your subscription was successfully created.")
    end
      
    it "should fail with declined card" do
      visit new_subscription_path
      GATEWAYCIM.success = false
      fill_in "subscription_contact_info_attributes_first_name", :with => "Bob"
      fill_in "subscription_contact_info_attributes_last_name", :with => "Jones"
      fill_in "Email", :with => "bobjones@123.com"
      fill_in "Address", :with => "123 fake st"
      fill_in "City", :with => "seattle"
      fill_in "State", :with => "wa"
      fill_in "Zip", :with => "98123"
      select 'United States', :from => 'Country'
      fill_in "subscription_contact_info_attributes_phone_area_code", :with => "206"
      fill_in "subscription_contact_info_attributes_phone_prefix", :with => "123"
      fill_in "subscription_contact_info_attributes_phone_suffix", :with => "1234"
      fill_in "Card number", :with => "4222222222222"
      select 'Visa', :from => "Card type"
      fill_in "Card verification", :with => "332"
      select '10', :from => "Expiry month"
      select Date.today.year.to_s, :from => "Expiry year"
      choose 'Gold'
      
      click_on 'Create Subscription'
      page.should have_content("The transaction was unsuccessful.")
      GATEWAYCIM.success = true
    end
    
    
  end
  describe 'DELETE /subscription' do
    
    before(:each) do
      @plan = Factory.build(:plan, :name => "Gold", :price => 20)
      @contact_info = Factory.build(:contact_info)
      @credit_card = Factory.build(:credit_card)
      @subscription = Factory(:subscription, :contact_info => @contact_info, :plan => @plan, :credit_card => @credit_card)
      @user = Factory(:user, :subscription => @subscription)
    end
    
    
    it 'should set subscription status to canceled' do
      visit subscription_path
      click_on "Cancel Subscription"
      page.should have_content("Your subscription has been canceled.")
    end
  end
  
end