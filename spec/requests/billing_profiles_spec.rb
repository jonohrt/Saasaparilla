require 'spec_helper'

describe 'Billing profiles' do
 
  
  describe "POST /billing_profiles" do
    it "should create new billing_profile"do
      visit new_billing_profile_path
      fill_in "plan_name", :with => "Silver"
      fill_in "Price", :with => "12.99"
      fill_in "attribute_name", :with => "Testing123"
      click_link "Add attribute"
      page.should have_content("Testing123")
      fill_in 'field_Testing123', :with => 'test'
      click_button "Create"
      page.should have_content("Plan was successfully created.")
      page.should have_content("Silver")
    end
    
  end
  
  
  
end