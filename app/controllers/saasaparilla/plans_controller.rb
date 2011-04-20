class Saasaparilla::PlansController < ApplicationController
  unloadable
  include Authentication::InstanceMethods
  before_filter :get_subscription, :only => [:edit, :update]
  
  def edit
  end

  def update
    if @subscription.update_attributes(params[:subscription])
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
