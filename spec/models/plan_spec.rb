require 'spec_helper'

describe Plan do
  it {should validate_presence_of :name}
  it {should validate_presence_of :billing_period}
  it {should validate_numericality_of :price}
  it {should validate_presence_of :price}
  it {should allow_mass_assignment_of :name}
  it {should allow_mass_assignment_of :billing_period}
  
  it { should have_many :subscriptions}

  it 'should have dynamic attributes' do 
    p = Factory.create(:plan)
    p.update_attributes(:field_testing => "test")
    p.testing.should == "test"
  end
end