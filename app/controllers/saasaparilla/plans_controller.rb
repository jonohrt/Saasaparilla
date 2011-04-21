class Saasaparilla::PlansController < ApplicationController
  unloadable
  include Authentication::InstanceMethods
  before_filter :get_subscription, :only => [:edit, :update]
  
  def edit
    @plans = Plan.all(:order => 'price ASC')
  end

  def update
    if params[:subscription][:plan_id] == ""
      @subscription.cancel
      redirect_to(subscription_path, :notice => 'You have been downgraded to the free plan.')
      return
    elsif @subscription.downgrade_plan_to(params[:subscription][:plan_id])
      redirect_to(subscription_path, :notice => 'Plan was successfully changed.')
    else
      render :action => "edit"
    end
  end
  
  private 
  
  def get_subscription
    @subscription = current_billable.subscription
    if @subscription.nil?
      flash[:error] = "You do not have a current subscription"
      redirect_to new_subscription_path
    end
  end
  
  
  
end
