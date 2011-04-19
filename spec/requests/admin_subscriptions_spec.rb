require 'spec_helper'

describe "admin/subscriptions" do
  before(:each) do
    @plan = Factory.build(:plan, :name => "Gold", :price => 20)
    @contact_info = Factory.build(:contact_info)

    @credit_card = Factory.build(:credit_card)
    @subscription = Factory.build(:subscription, :contact_info => @contact_info, :plan => @plan, :credit_card => @credit_card)
    @user = Factory.create(:user, :subscription => @subscription)
    @contact_info2 = Factory.build(:contact_info)

    @credit_card2 = Factory.build(:credit_card)
    @subscription2 = Factory.build(:subscription, :contact_info => @contact_info2, :plan => @plan, :credit_card => @credit_card2)
    @user2 = Factory.create(:user, :subscription => @subscription2)
  end
  
  it 'should load index page' do
    visit admin_subscriptions_path
    page.should have_content("Listing Subscriptions")
    page.should have_content("bobjones@123.com")
  end
  
  it 'should load subscription show path' do
    visit admin_subscriptions_path
    click_on("Show Detail")
    page.should have_content("Subscription Details")
    
  end
  
end