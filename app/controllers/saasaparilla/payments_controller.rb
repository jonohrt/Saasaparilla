class Saasaparilla::PaymentsController < ApplicationController
  unloadable
  include Authentication::InstanceMethods
  ssl_required :new, :create, :edit, :update, :show 
  before_filter :get_subscription
  before_filter :get_payment, :only => [:edit, :update]
  before_filter :check_pending, :only => [:edit, :update]
  def new
    @payment = @subscription.payments.build
  end
  
  def create
    @payment = @subscription.payments.build(params[:payment])
     if @payment.save
       redirect_to edit_subscription_payment_path(@payment)
     else
       render :action => "new"
     end
  end
  
  def edit
    
  end
  
  def update

    begin
      if @payment.update_attributes(params[:payment])
        flash[:notice] = "Thank you, your payment has been processed."
        redirect_to subscription_payment_path
      else
        flash[:error] = "An error has occured when trying to process your payment."
        render :action => "edit"
      end
    rescue Exception => e
         flash[:error] = e.message
         render :action => "edit"
         flash.discard
    end
  end
  
  def show
    @payment = @subscription.payments.find(params[:id])
  end
  
  
  
  private
  
  def get_subscription
    @subscription = current_billable.subscription
  end
  
  def get_payment

    @payment = @subscription.payments.find(params[:id])

  end
  
  def check_pending
    unless @payment.pending?
      flash[:error] = "Payment has already been paid."
      redirect_to new_subscription_payment_path
    end
    
  end
  
  

  
end