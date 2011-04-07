class Saasaparilla::CreditCardsController < ApplicationController
  unloadable
  
  layout 'saasaparilla'
  
  def index
    @account = Account.find(params[:account_id])
    @credit_card = @account.credit_card
  end
  
  def update
    @account = Account.find(params[:account_id])
    @credit_card = Credit_card.find(params[:id])
    
    if @account.credit_card.update_attributes(params[:credit_card])
      flash[:notice] = "Your credit card was successfully updated"
      
    else
      raise "Error"
    end
  end
  
end