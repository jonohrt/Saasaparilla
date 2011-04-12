class Saasaparilla::InvoicesController < ApplicationController
  
  unloadable
  before_filter :get_invoice
  def show
    
  end
  
  
  def get_invoice
    @invoice = Invoice.find(params[:id])
    
    unless @invoice.billing_activity.account == current_billable.account
      flash[:error] = "Unauthorized to access this invoice"
      redirect_to account_path
    end
  end
end