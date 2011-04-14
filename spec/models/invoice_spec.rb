require 'spec_helper'

describe Invoice do
  it { should belong_to :billing_activity }
  it { should have_many :invoice_line_items }

  describe 'on create' do

    before(:all) do
      plan = Factory.build(:plan, :name => "Gold", :price => 20.0)
      contact_info = Factory.build(:contact_info)
      credit_card = Factory.build(:credit_card)
      @subscription = Factory.build(:subscription, :contact_info => contact_info, :plan => plan, :credit_card => credit_card)
      @subscription.save
    end
  
    it 'should send invoice_created email' do
      ActionMailer::Base.deliveries = [];
      @subscription.invoice!
      ActionMailer::Base.deliveries.first.subject.should =~ /Invoice Created/      
    end

  end

end