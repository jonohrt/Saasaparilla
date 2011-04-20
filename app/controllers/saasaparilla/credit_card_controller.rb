class Saasaparilla::CreditCardController < ApplicationController
  unloadable
  include Authentication::InstanceMethods
  before_filter :set_subscription
  before_filter :set_credit_cards
  
  
  def edit

  end
  
  def update
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
 
  private 
   
  def set_subscription
    @subscription = current_billable.subscription
  end
  
  def set_credit_cards
    @credit_card = @subscription.credit_card
    @current_card = @credit_card.clone
  end
  
end