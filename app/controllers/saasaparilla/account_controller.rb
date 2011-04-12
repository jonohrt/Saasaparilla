class Saasaparilla::AccountController < ApplicationController
  unloadable
  
  before_filter :get_account, :only => [:show, :destroy]
  
  #overide with authorization
  def new
    @account = current_billable.build_account
    @account.build_contact_info
    @account.build_credit_card
    @subscription = @account.build_subscription

    
  end
  
  
  def create
    @account = current_billable.build_account(params[:account])
    
    begin
      if @account.save
        redirect_to account_path
        flash[:notice] = "Your account was successfully created."
      else
        render :action => "new"
        flash[:error] = "Your account could not be created due to errors. Please review the form and correct them."
      
      end
      
    rescue Exception => e
        flash[:error] = e.message
        render :action => "new"
        flash.discard
    end
  end
  
  def show

  end
  
  
  def destroy
    if @account.cancel
      flash[:notice] = "Your account has been canceled."
      redirect_to account_path
      
    end
  end
  
  private
  def get_account
    @account = current_billable.account
  end
end