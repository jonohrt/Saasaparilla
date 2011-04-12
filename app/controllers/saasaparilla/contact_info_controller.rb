class Saasaparilla::ContactInfoController < ApplicationController
  unloadable
  
  before_filter :get_account
  before_filter :get_contact_info
  
  def edit
    
  end
  
  def update
    if @contact_info.update_attributes(params[:contact_info])
      flash[:notice] = "Contact info was successfully updated."
      redirect_to account_path
    else
      flash[:error] = "An error has occurred when trying to update your contact info."
      render :action => "edit"
    end
  end
  
  private 
  
  def get_account
    @account = current_billable.account
  end
  
  def get_contact_info
    @contact_info = @account.contact_info
  end
  
end