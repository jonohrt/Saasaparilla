require 'spec_helper'

describe 'Plans' do

  describe 'GET /subscriptions/plans' do
    before(:each) do
      @plan = Factory(:plan, :name => "Gold", :price => 20)
      @plan2 = Factory(:plan, :name => "Silver", :price => 10)
      @contact_info = Factory.build(:contact_info)

      @credit_card = Factory.build(:credit_card)

      @subscription = Factory.build(:subscription, :contact_info => @contact_info, :plan => @plan, :credit_card => @credit_card)

      @user = Factory(:user, :subscription => @subscription)
    end
    it 'should not show current plan on downgrade' do
      visit edit_subscription_plan_path
      page.should have_content("Silver")
      
      page.should have_content("You are currently subscribed to this plan")
      
    end
    it 'should set downgrade_to_plan on downgrade' do
      visit edit_subscription_plan_path
      click_on("Downgrade")
      page.should have_content("Plan was successfully changed.")
      @subscription.reload
      @subscription.plan.should == @plan
      @subscription.downgrade_to_plan.should == @plan2
    end
    
  end
end