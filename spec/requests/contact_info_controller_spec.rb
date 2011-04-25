require 'spec_helper'

describe 'Contact info' do
  
  describe 'GET /contact' do
    
    before(:each) do
          
          @plan = Factory.build(:plan, :name => "Gold", :price => 20)
          @contact_info = Factory.build(:contact_info)
  
          @credit_card = Factory.build(:credit_card)
          @subscription = Factory.build(:subscription, :contact_info => @contact_info, :plan => @plan, :credit_card => @credit_card)
          @user = Factory.create(:user, :subscription => @subscription)
       end
       
       it 'should display contact form' do
         visit edit_subscription_contact_info_path
         page.should have_content 'Update Billing Contact Info'
         
       end
    
  end
  
   describe 'POST /contact-info' do
     before(:each) do
       @plan = Factory.build(:plan, :name => "Gold", :price => 20)
       @contact_info = Factory.build(:contact_info)

       @credit_card = Factory.build(:credit_card)
       @subscription = Factory.build(:subscription, :contact_info => @contact_info, :plan => @plan, :credit_card => @credit_card)
       @user = Factory.create(:user, :subscription => @subscription)
     end
     
     it 'should update contact info' do
       visit edit_subscription_contact_info_path
       fill_in "First name", :with => "Ted"
       click_on("Update Contact Info")
       page.should have_content("Contact info was successfully updated.")
       page.should have_content("Ted")
     end
   end
   
  
end