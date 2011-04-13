require 'spec_helper'

describe 'Payments' do

  describe 'GET /payments' do

    it 'should not allow payment for an subscription with no balance' do
      @plan = Factory.build(:plan, :name => "Gold", :price => 20)
      @contact_info = Factory.build(:contact_info)

      @credit_card = Factory.build(:credit_card)
      @subscription = Factory(:subscription, :contact_info => @contact_info, :plan => @plan,:credit_card => @credit_card)
      @user = Factory(:user, :subscription => @subscription)
      @subscription.balance = 0.0
      visit new_subscription_payment_path
      page.should have_content("$0.00")
      fill_in "Amount", :with => "12.00"
      click_on "Submit"
      page.should have_content("cannot be more than your balance")
    end
    
    it 'should allow payment to be created' do
       @plan = Factory.build(:plan, :name => "Gold", :price => 20)
       @contact_info = Factory.build(:contact_info)
     
       @credit_card = Factory.build(:credit_card)
       @subscription = Factory(:subscription, :contact_info => @contact_info, :plan => @plan, :credit_card => @credit_card)
       @user = Factory(:user, :subscription => @subscription)
       @subscription.update_attributes(:balance => 20.00)
       visit new_subscription_payment_path
       page.should have_content("$20.00")
       fill_in "Amount", :with => 13.00
       click_on "Submit"
       page.should have_content("Confirm Payment")
       
    end
    
  

     
  end
  
  describe 'POST /payments' do
    it 'should not allow payment without pending status' do
      @plan = Factory.build(:plan, :name => "Gold", :price => 20)
      @contact_info = Factory.build(:contact_info)
  
      @credit_card = Factory.build(:credit_card)
      
      @subscription = Factory(:subscription, :contact_info => @contact_info, :plan => @plan, :credit_card => @credit_card)
      @subscription.update_attributes(:balance => 15)
      @payment = Factory(:payment,  :amount => 12, :subscription => @subscription)
      @user = Factory(:user, :subscription => @subscription)
      
      
      
      Payment.skip_callback(:update, :before, :charge_subscription)  
      @payment.update_attributes(:status => "paid")
      
      
      visit edit_subscription_payment_path(@payment)
      page.should have_content("Payment has already been paid")
    end
    
    it 'should allow updated payments that have not been paid' do
      @plan = Factory.build(:plan, :name => "Gold", :price => 20)
      @contact_info = Factory.build(:contact_info)
 
      @credit_card = Factory.build(:credit_card)
     
      @subscription = Factory(:subscription, :contact_info => @contact_info, :plan => @plan, :credit_card => @credit_card)
      @subscription.update_attributes(:balance => 15)
      @payment = Factory(:payment, :amount => 12, :subscription => @subscription)
      
    
      @user = Factory(:user, :subscription => @subscription)
    
      visit edit_subscription_payment_path(@payment)
      page.should have_content("Confirm Payment")
   
      click_on "Confirm"
      
      page.should have_content("Thank you, your payment has been processed.")
      page.should have_content("$12.00")
    end
  end
  
  
end
