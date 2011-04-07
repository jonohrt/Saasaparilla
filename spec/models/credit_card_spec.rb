require 'spec_helper'

describe CreditCard do
  
  it { should belong_to :account }
  
  
  it 'should produce credit card from valid attributes' do
      credit_card = Factory(:credit_card)
      
      credit_card.active_merchant_card.class.should == ActiveMerchant::Billing::CreditCard


   end
   
  describe 'Card save' do
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
  
  
end