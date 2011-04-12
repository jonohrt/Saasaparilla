require 'spec_helper'

describe 'Notifier' do

  describe 'subscription created email' do

    before(:all) do
      plan = Factory.build(:plan, :name => "Gold", :price => 20.0)
      contact_info = Factory.build(:contact_info)
      subscription = Factory.build(:subscription, :plan => plan)
      credit_card = Factory.build(:credit_card)
      @account = Factory.build(:account, :contact_info => contact_info, :subscription => subscription, :credit_card => credit_card)
      @email = Saasaparilla::Notifier.subscription_created(@account)
    end
    
    it "should deliver to the account passed in" do
      @email.should deliver_to(@account.contact_info.email)
    end
    
    it "should contain the plan in the mail body" do
      @email.should have_body_text(/Gold/)
    end

    it "should contain the billing period in the mail body" do
      @email.should have_body_text(/monthly/)
    end
    
  end

  # describe 'invoice created email' do
  # 
  #   before(:all) do
  #     plan = Factory.build(:plan, :name => "Gold", :price => 20.0)
  #     contact_info = Factory.build(:contact_info)
  #     subscription = Factory.build(:subscription, :plan => plan)
  #     credit_card = Factory.build(:credit_card)
  #     @account = Factory.build(:account, :contact_info => contact_info, :subscription => subscription, :credit_card => credit_card)
  #     @account.invoice!
  #     @email = Saasaparilla::Notifier.invoice_created(@account)
  #   end
  #   
  #   it "should deliver to the account passed in" do
  #     @email.should deliver_to(@account.contact_info.email)
  #   end
  #   
  #   it "should contain the plan in the mail body" do
  #     @email.should have_body_text(/Gold/)
  #   end
  # 
  #   it "should contain the billing period in the mail body" do
  #     @email.should have_body_text(/monthly/)
  #   end
  #   
  # end

  describe 'account billed successfully email' do

    before(:all) do
      plan = Factory.build(:plan, :name => "Gold", :price => 20.0)
      contact_info = Factory.build(:contact_info)
      subscription = Factory.build(:subscription, :plan => plan)
      credit_card = Factory.build(:credit_card)
      @account = Factory.build(:account, :contact_info => contact_info, :subscription => subscription, :credit_card => credit_card)
      @email = Saasaparilla::Notifier.account_billing_successful(@account, 20)
    end
    
    it "should deliver to the account passed in" do
      @email.should deliver_to(@account.contact_info.email)
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
  
  describe 'account billing failed email' do

    before(:all) do
      plan = Factory.build(:plan, :name => "Gold", :price => 20.0)
      contact_info = Factory.build(:contact_info)
      subscription = Factory.build(:subscription, :plan => plan)
      credit_card = Factory.build(:credit_card)
      @account = Factory.build(:account, :contact_info => contact_info, :subscription => subscription, :credit_card => credit_card)
      @email = Saasaparilla::Notifier.account_billing_failed(@account)
    end
    
    it "should deliver to the account passed in" do
      @email.should deliver_to(@account.contact_info.email)
    end
    
    it "should contain the plan in the mail body" do
      @email.should have_body_text(/Gold/)
    end

    it "should contain the billing period in the mail body" do
      @email.should have_body_text(/monthly/)
    end

    it "should contain the #edit_account_credit_card_url in the mail body" do
      @email.should have_body_text(/#{edit_account_credit_card_url}/)
    end
    
  end
  
  
  describe 'pending cancellation notice email' do

    before(:all) do
      plan = Factory.build(:plan, :name => "Gold", :price => 20.0)
      contact_info = Factory.build(:contact_info)
      subscription = Factory.build(:subscription, :plan => plan)
      credit_card = Factory.build(:credit_card)
      @account = Factory.build(:account, :contact_info => contact_info, :subscription => subscription, :credit_card => credit_card)
      @email = Saasaparilla::Notifier.pending_cancellation_notice(@account)
    end
    
    it "should deliver to the account passed in" do
      @email.should deliver_to(@account.contact_info.email)
    end
    
    it "should contain the plan in the mail body" do
      @email.should have_body_text(/Gold/)
    end

    it "should contain the billing period in the mail body" do
      @email.should have_body_text(/monthly/)
    end

    it "should contain the #edit_account_credit_card_url in the mail body" do
      @email.should have_body_text(/#{edit_account_credit_card_url}/)
    end
    
  end
  
  
  describe 'account cancelled email' do

    before(:all) do
      plan = Factory.build(:plan, :name => "Gold", :price => 20.0)
      contact_info = Factory.build(:contact_info)
      subscription = Factory.build(:subscription, :plan => plan)
      credit_card = Factory.build(:credit_card)
      @account = Factory.build(:account, :contact_info => contact_info, :subscription => subscription, :credit_card => credit_card)
      @email = Saasaparilla::Notifier.account_cancelled(@account)
    end
    
    it "should deliver to the account passed in" do
      @email.should deliver_to(@account.contact_info.email)
    end
    
    it "should contain the plan in the mail body" do
      @email.should have_body_text(/You account has been cancelled/)
    end
    
  end
  
end