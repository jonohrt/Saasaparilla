require 'spec_helper'

describe BillingProfile do
  it {should validate_presence_of :customer_cim_id}
  it 'should return true' do
    true
  end
  
    
end
