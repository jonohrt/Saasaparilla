class Saasaparilla::Admin::SubscriptionsController < ApplicationController
  
  unloadable
  include Authentication::InstanceMethods
  include Authorization::InstanceMethods
  
  # GET /admin/subscriptions
  def index
    @subscriptions = Subscription.all.paginate(:page => params[:page], :per_page => 20, :order => "created_at DESC")
  end
  
  def show
    @subscription = Subscription.find(params[:id])
  end
  
  def toggle_no_charge
    @subscription = Subscription.find(params[:id])
    @subscription.toggle!(:no_charge)
    redirect_to admin_subscription_path(@subscription)
    if @subscription.no_charge
      flash[:notice] = "Subscription will not be charged."
    else
      flash[:notice] = "Subscription will now be charged."
    end
  end
  
  def cancel
    @subscription = Subscription.find(params[:id])
    @subscription.cancel
    redirect_to admin_subscription_path(@subscription)
    flash[:notice] = "Subscription was canceled."
  end
  
end