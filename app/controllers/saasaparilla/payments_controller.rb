class Saasaparilla::PaymentsController < ApplicationController
  unloadable
  before_filter :get_account
  before_filter :get_payment, :only => [:edit, :update]
  before_filter :check_pending, :only => [:edit, :update]
  def new
    @payment = @account.payments.build
  end
  
  def create
    @payment = @account.payments.build(params[:payment])
     if @payment.save
       redirect_to edit_account_payment_path(@payment)
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
        redirect_to account_payment_path
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
    @payment = @account.payments.find(params[:id])
  end
  
  
  
  private
  
  def get_account
    @account = current_billable.account
  end
  
  def get_payment

    @payment = @account.payments.find(params[:id])

  end
  
  def check_pending
    unless @payment.pending?
      flash[:error] = "Payment has already been paid."
      redirect_to new_account_payment_path
    end
    
  end
  

  
end