class Saasaparilla::SubscriptionController < ApplicationController
  unloadable
  ssl_required :new, :create, :show 
  include Authentication::InstanceMethods
  before_filter :get_subscription, :only => [:show, :destroy, :reactivate]

  before_filter :require_no_subscription, :only => [:new]
  #overide with authorization
  def new
    @subscription = current_billable.build_subscription
    @subscription.build_contact_info
    @subscription.build_credit_card
  end
  
  def create
    @subscription = current_billable.build_subscription(params[:subscription])
    
    begin
      if @subscription.save
        redirect_to subscription_path
        flash[:notice] = "Your subscription was successfully created."
      else
        render :action => "new"
        flash[:error] = "Your subscription could not be created due to errors. Please review the form and correct them."
      end
    rescue Exception => e
        flash[:error] = e.message
        render :action => "new"
        flash.discard
    end
  end
  
  def show

  end
  
  def reactivate
    if @subscription.reactivate!
      redirect_to subscription_path
      flash[:notice] = "Your subscription was successfully reactivated."
    else
      redirect_to subscription_path
      flash[:error] = "There was a problem reactivating your account."
    end
  end
  
  def destroy
    if @subscription.cancel
      flash[:notice] = "Your subscription has been canceled."
      redirect_to subscription_path
      
    end
  end
  
  private
  def require_no_subscription
    unless current_billable.subscription.nil?
      flash[:error] = "You already have a subscription"
      redirect_to subscription_path
    end
  end
  def get_subscription
    @subscription = current_billable.subscription
    if @subscription.nil?
      flash[:error] = "You do not have a current subscription"
      redirect_to new_subscription_path
    end
  end
  

end