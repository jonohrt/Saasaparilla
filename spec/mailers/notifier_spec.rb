require 'spec_helper'

describe 'Notifier' do

  describe 'subscription created email' do

    before(:all) do
      plan = Factory.build(:plan, :name => "Gold", :price => 20.0)
      contact_info = Factory.build(:contact_info)
      credit_card = Factory.build(:credit_card)
      @subscription = Factory.build(:subscription, :contact_info => contact_info, :plan => plan, :credit_card => credit_card)
      @email = Saasaparilla::Notifier.subscription_created(@subscription)
    end
    
    it "should deliver to the subscription passed in" do
      @email.should deliver_to(@subscription.contact_info.email)
    end
    
    it "should contain the plan in the mail body" do
      @email.should have_body_text(/Gold/)
    end

    it "should contain the billing period in the mail body" do
      @email.should have_body_text(/monthly/)
    end
    
  end

  describe 'invoice created email' do
  
    before(:all) do
      plan = Factory.build(:plan, :name => "Gold", :price => 20.0)
      contact_info = Factory.build(:contact_info)
      credit_card = Factory.build(:credit_card)
      @subscription = Factory.build(:subscription, :contact_info => contact_info, :plan => plan, :credit_card => credit_card)
      @subscription.invoice!
      @invoice = BillingActivity.recent.first.invoice
      @email = Saasaparilla::Notifier.invoice_created(@subscription, @invoice)
    end
    
    it "should deliver to the subscription passed in" do
      @email.should deliver_to(@subscription.contact_info.email)
    end
    
    it "should contain the plan in the mail body" do
      @email.should have_body_text(/Gold/)
    end
  
    it "should contain the line item amount the mail body" do
      @email.should have_body_text(/20/)
    end
    
  end

  describe 'subscription billed successfully email' do

    before(:all) do
      plan = Factory.build(:plan, :name => "Gold", :price => 20.0)
      contact_info = Factory.build(:contact_info)
  
      credit_card = Factory.build(:credit_card)
      @subscription = Factory.build(:subscription, :contact_info => contact_info, :plan => plan, :credit_card => credit_card)
      @email = Saasaparilla::Notifier.subscription_billing_successful(@subscription, 20)
      
    end
    
    it "should deliver to the subscription passed in" do
      @email.should deliver_to(@subscription.contact_info.email)
    end
    
    it "should contain the plan in the mail body" do
      @email.should have_body_text(/Gold/)
    end

    it "should contain the billing period in the mail body" do
      @email.should have_body_text(/monthly/)
    end

    it "should contain the amount billed in the mail body" do
      @email.should have_body_text(/20/)
    end

  end  
  
  describe 'subscription billing failed email' do

    before(:all) do
      plan = Factory.build(:plan, :name => "Gold", :price => 20.0)
      contact_info = Factory.build(:contact_info)

      credit_card = Factory.build(:credit_card)
      @subscription = Factory.build(:subscription, :contact_info => contact_info, :plan => plan, :credit_card => credit_card)
      @email = Saasaparilla::Notifier.subscription_billing_failed(@subscription)
    end
    
    it "should deliver to the subscription passed in" do
      @email.should deliver_to(@subscription.contact_info.email)
    end
    
    it "should contain the plan in the mail body" do
      @email.should have_body_text(/Gold/)
    end

    it "should contain the billing period in the mail body" do
      @email.should have_body_text(/monthly/)
    end

    it "should contain the #edit_subscription_credit_card_url in the mail body" do
      @email.should have_body_text(/#{edit_subscription_credit_card_url(:host => "test.com")}/)
    end
    
  end
  
  
  describe 'pending cancellation notice email' do

    before(:all) do
      plan = Factory.build(:plan, :name => "Gold", :price => 20.0)
      contact_info = Factory.build(:contact_info)

      credit_card = Factory.build(:credit_card)
      @subscription = Factory.build(:subscription, :contact_info => contact_info, :plan => plan, :credit_card => credit_card)
      @email = Saasaparilla::Notifier.pending_cancellation_notice(@subscription)
    end
    
    it "should deliver to the subscription passed in" do
      @email.should deliver_to(@subscription.contact_info.email)
    end
    
    it "should contain the plan in the mail body" do
      @email.should have_body_text(/Gold/)
    end

    it "should contain the billing period in the mail body" do
      @email.should have_body_text(/monthly/)
    end

    it "should contain the #edit_subscription_credit_card_url in the mail body" do
      @email.should have_body_text(/#{edit_subscription_credit_card_url(:host => "test.com")}/)
    end
    
  end
  
  
  describe 'subscription cancelled email' do

    before(:all) do
      plan = Factory.build(:plan, :name => "Gold", :price => 20.0)
      contact_info = Factory.build(:contact_info)
   
      credit_card = Factory.build(:credit_card)
      @subscription = Factory.build(:subscription, :contact_info => contact_info, :plan => plan, :credit_card => credit_card)
      @email = Saasaparilla::Notifier.subscription_cancelled(@subscription)
    end
    
    it "should deliver to the subscription passed in" do
      @email.should deliver_to(@subscription.contact_info.email)
    end
    
    it "should contain the plan in the mail body" do
      @email.should have_body_text(/Your subscription has been cancelled/)
    end
    
  end
  
end