require 'spec_helper'
describe Payment do
  before(:each) do
    @plan = Factory.build(:plan, :name => "Gold", :price => 20)
    @contact_info = Factory.build(:contact_info)
    @subscription = Factory.build(:subscription, :plan => @plan)
    @credit_card = Factory.build(:credit_card)
    
    @account = Factory(:account, :contact_info => @contact_info, :subscription => @subscription, :credit_card => @credit_card)
    
    @account.update_attributes(:balance => 15)
    @payment = Factory(:payment, :amount => 12, :account => @account)
    @user = Factory(:user, :account => @account)
    
  end
  
  
  it 'should create a successful transaction on update' do
    @payment.should_receive(:charge_account)
    @payment.save
  end
  
  it 'should set status to paid after bill!' do
    @payment.save
    @payment.status.should == 'paid'
  end
  
  
end