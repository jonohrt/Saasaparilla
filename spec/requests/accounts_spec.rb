require 'spec_helper'

describe 'Accounts' do
  
  describe 'Post /accounts' do
    before(:each) do
      Factory.create(:plan, :name => "Gold")
      Factory.create(:plan, :name => "Silver")
    end
    it "should create a new account" do
      visit new_account_path
      fill_in "account_contact_info_attributes_first_name", :with => "Bob"
      fill_in "account_contact_info_attributes_last_name", :with => "Jones"
      fill_in "Email", :with => "bobjones@123.com"
      fill_in "Address", :with => "123 fake st"
      fill_in "City", :with => "seattle"
      fill_in "State", :with => "wa"
      fill_in "Zip", :with => "98123"
      select 'United States', :from => 'Country'
      fill_in "account_credit_card_attributes_first_name", :with => "Bob"
      fill_in "account_credit_card_attributes_last_name", :with => "Herman"
      fill_in "Phone number", :with => "206-123-1234"
      fill_in "Card number", :with => "4111111111111111"
      select 'Visa', :from => "Card type"
      fill_in "Card verification", :with => "332"
      select '10', :from => "Expiry month"
      select Date.today.year.to_s, :from => "Expiry year"
      choose 'Gold'
      click_on 'Create Account'
      page.should have_content("Your account was successfully created.")
    end
  end
  
end