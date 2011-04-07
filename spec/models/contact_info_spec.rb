require 'spec_helper'

describe ContactInfo do
  it { should belong_to :account }
  it { should validate_presence_of :first_name}
  it { should validate_presence_of :last_name}
  it { should validate_presence_of :email}
  it { should validate_presence_of :address}
  it { should validate_presence_of :city}
  it { should validate_presence_of :state}
  it { should validate_presence_of :zip}
  it { should validate_presence_of :country}
  it { should validate_presence_of :phone_number}


  it 'should make full name' do
    contact_info = Factory(:contact_info)
    contact_info.full_name.should == "#{contact_info.first_name} #{contact_info.last_name}"
    
  end
end