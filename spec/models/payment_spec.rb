require 'spec_helper'
describe Payment do
  before(:each) do
    @plan = Factory.build(:plan, :name => "Gold", :price => 20)
    @contact_info = Factory.build(:contact_info)

    @credit_card = Factory.build(:credit_card)
    
    @subscription = Factory(:subscription, :contact_info => @contact_info, :plan => @plan, :credit_card => @credit_card)
    
    @subscription.update_attributes(:balance => 15)
    @payment = Factory(:payment, :amount => 12, :subscription => @subscription)
    @user = Factory(:user, :subscription => @subscription)
    
  end
  
  
  it 'should create a successful transaction on update' do
    @payment.should_receive(:charge_subscription)
    @payment.save
  end
  
  it 'should set status to paid after bill!' do
    @payment.save
    @payment.status.should == 'paid'
  end
  
  
end