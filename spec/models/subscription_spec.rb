require 'spec_helper'
describe Subscription do
  it {should belong_to :account }
  it {should belong_to :plan}
  
  it 'should set status to pending on create' do
    subscription = Factory(:subscription, :plan => Factory(:plan))
    subscription.pending?.should == true
  end
end