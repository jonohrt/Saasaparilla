require 'spec_helper'

describe 'Contact info' do
  
  describe 'GET /contact' do
    
    before(:each) do
          
          @plan = Factory.build(:plan, :name => "Gold", :price => 20)
          @contact_info = Factory.build(:contact_info)
          @subscription = Factory.build(:subscription, :plan => @plan)
          @credit_card = Factory.build(:credit_card)
          @account = Factory.build(:account, :contact_info => @contact_info, :subscription => @subscription, :credit_card => @credit_card)
          @user = Factory.create(:user, :account => @account)
       end
       
       it 'should display contact form' do
         visit edit_account_contact_info_path
         page.should have_content 'Update Contact Info'
         
       end
    
  end
  
   describe 'POST /contact-info' do
     before(:each) do
       @plan = Factory.build(:plan, :name => "Gold", :price => 20)
       @contact_info = Factory.build(:contact_info)
       @subscription = Factory.build(:subscription, :plan => @plan)
       @credit_card = Factory.build(:credit_card)
       @account = Factory.build(:account, :contact_info => @contact_info, :subscription => @subscription, :credit_card => @credit_card)
       @user = Factory.create(:user, :account => @account)
     end
     
     it 'should update contact info' do
       visit edit_account_contact_info_path
       fill_in "First name", :with => "Ted"
       click_on("Update Contact Info")
       page.should have_content("Contact info was successfully updated.")
       page.should have_content("Ted")
     end
   end
   
  
end