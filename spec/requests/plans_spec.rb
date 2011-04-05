require 'spec_helper'

describe 'Plans' do
  describe "GET /plans" do
    it "should display plans" do
      Factory.create(:plan, :name => "Gold")
      visit plans_path
      page.should have_content("Gold")
    end
  end
  
  describe "POST /plans" do
    it "should create new plan", :js => true do
      visit new_plan_path
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