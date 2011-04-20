class Saasaparilla::Admin::TransactionsController < ApplicationController
  
  unloadable
  include Authentication::InstanceMethods
  include Authorization::InstanceMethods
  
  # GET /admin/subscriptions
  def index
    @subscription = Subscription.find(params[:subscription_id])
    @transactions = @subscription.transactions.paginate(:page => params[:page], :per_page => 20, :order => "created_at DESC")
  end
  

end