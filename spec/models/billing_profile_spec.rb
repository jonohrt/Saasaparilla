require 'spec_helper'

describe BillingProfile do
  #it {should validate_presence_of :customer_cim_id}
  it 'should return true' do
    true
  end
  it {should belong_to :billable}
  
  it 'should make parent billable if is_billable' do
    user = Factory.create(:user)
    user.billable?
    user.create_billing_profile
    user.billing_profile.billable.should == user
  end
  
  it 'should add cim number on create' do
    billing_profile = Factory.create(:billing_profile)
    billing_profile.customer_cim_id.should_not be_nil
  end
    
end
