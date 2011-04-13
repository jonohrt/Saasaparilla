class Saasaparilla::CreditCardController < ApplicationController
  unloadable
  
  
  
  def edit
    @subscription = current_billable.subscription
    @credit_card = @subscription.credit_card
  end
  
  def update
    @subscription = current_billable.subscription
    @credit_card = @subscription.credit_card
    begin 
      if @subscription.credit_card.update_attributes(params[:credit_card])
        flash[:notice] = "Your credit card was successfully updated."
        redirect_to subscription_path
      else
        # @credit_card = @credit_card.reload_with_errors
        render :action => "edit"
        flash[:error] = "Your credit card could not be updated due to errors. Please review the form and correct them."
      end
     rescue Exception => e
          flash[:error] = e.message
          render :action => "edit"
          flash.discard
      end
  end
  
end