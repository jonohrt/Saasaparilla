class BillingProfileController < ApplicationController
  #override me
  def new
    
    @billing_profile = BillingProfile.new
    @billing_profile.billing_address = Address.new
    
  end
  
end