require 'spec_helper'

describe CreditCard do
  
  it { should belong_to :account }
  
  
  it 'should produce credit card from valid attributes' do
      credit_card = Factory(:credit_card)
      
      credit_card.active_merchant_card.class.should == ActiveMerchant::Billing::CreditCard


   end
   
  describe 'Card create' do
    before(:each) do
      @credit_card = Factory(:credit_card)
    end
   it 'should retain card number' do 
      @credit_card.card_number.should_not == nil
    end
      
    it 'should retain masked card number' do 
      @credit_card.card_number.should == "XXXXXXXXXXXX1111"
    end
  
    it 'should retain expiration date' do
      @credit_card.expiration_date.should == "10/2011"
    end
  end
  
  
  describe 'Card Update' do
    before(:each) do
      @plan = Factory.build(:plan, :name => "Gold", :price => 20)
      @contact_info = Factory.build(:contact_info)
      @subscription = Factory.build(:subscription, :plan => @plan)
      @credit_card = Factory.build(:credit_card)
      @account = Factory(:account, :contact_info => @contact_info, :subscription => @subscription, :credit_card => @credit_card)
    end
  
  
    it 'should update card on auth.net' do
      @credit_card.should_receive(:update_payment_profile)
      @credit_card.update_attributes(:first_name =>"new",
            :last_name  => "value",
            :card_type => "Visa",
            :card_number => "4111111111111111",
            :card_verification => "545",
            :expiry_month => "10",
            :expiry_year => "2011")
          
     
    end
  
  end 
  
end