class Saasaparilla::CreditCardController < ApplicationController
  unloadable
  
  
  
  def show
    @account = current_billable.account
    @credit_card = @account.credit_card
  end
  
  def update
    @account = current_billable.account
    @credit_card = @account.credit_card
    begin 
      if @account.credit_card.update_attributes(params[:credit_card])
        flash[:notice] = "Your credit card was successfully updated."
        redirect_to account_credit_card_path(@account)
      else
        # @credit_card = @credit_card.reload_with_errors
        render :action => "show"
        flash[:error] = "Your credit card could not be updated due to errors. Please review the form and correct them."
      end
     rescue Exception => e
          flash[:error] = e.message
          render :action => "show"
          flash.discard
      end
  end
  
end