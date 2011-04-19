class Saasaparilla::Admin::SubscriptionsController < ActionController::Base
  
  unloadable

  include Authorization::InstanceMethods
  
  # GET /admin/subscriptions
  def index
    @subscriptions = Subscription.all.paginate(:page => params[:page], :per_page => 20, :order => "created_at DESC")
  end
  
  def show
    @subscription = Subscription.find(params[:id])
  end
  
  
  
  
  
  
end