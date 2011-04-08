class Saasaparilla::ContactInfoController < ApplicationController
  unloadable
  
  layout 'saasaparilla'
  
  def show
    @account = current_billable.account
    @contact_info = @account.contact_info
  end
  
end