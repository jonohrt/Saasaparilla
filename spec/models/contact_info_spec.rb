require 'spec_helper'

describe ContactInfo do

  it { should belong_to :subscription }
  it { should validate_presence_of :first_name}
  it { should validate_presence_of :last_name}
  it { should validate_presence_of :email}
  it { should validate_presence_of :address}
  it { should validate_presence_of :city}
  it { should validate_presence_of :state}
  it { should validate_presence_of :zip}
  it { should validate_presence_of :country}
  
  it 'should make full name' do
    contact_info = Factory(:contact_info)
    contact_info.full_name.should == "#{contact_info.first_name} #{contact_info.last_name}"
  end
  
  it 'should have a valid phone numer' do
    contact_info = Factory(:contact_info)
    contact_info.update_attributes :phone_area_code => "123", :phone_prefix => "123", :phone_suffix => "1234"
    contact_info.should be_valid
  end

  it 'should have errors with an invalid phone number' do
    contact_info = Factory(:contact_info)
    contact_info.update_attributes :phone_area_code => "1", :phone_prefix => "1", :phone_suffix => "1"
    contact_info.should_not be_valid
  end
  
end