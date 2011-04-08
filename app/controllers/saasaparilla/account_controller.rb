class Saasaparilla::AccountController < ApplicationController
  unloadable
  #overide with authorization
  def new
    @account = current_billable.build_account
    @account.build_contact_info
    @account.build_credit_card
    @subscription = @account.build_subscription

    
  end
  
  
  def create
    @account = current_billable.build_account(params[:account])
    
  
      if @account.save
        redirect_to account_path(@account)
        flash[:notice] = "Your account was successfully created."
      else
        render :action => "new"
        flash[:error] = "Your account could not be created due to errors. Please review the form and correct them."
      
      end
  
  end
  
  def show
    
  end
end