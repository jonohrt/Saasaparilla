class Saasaparilla::BillingHistoryController < ApplicationController
  unloadable
  include Authentication::InstanceMethods
  
  def show
    @billing_activities = current_billable.subscription.billing_activities.order('created_at asc')
    
  end
end