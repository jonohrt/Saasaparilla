Rails.application.routes.draw do
  resources :plans, :controller => "saasaparilla/plans"
  
  
  
  resource :account, :controller => "saasaparilla/account"
  
  scope '/account', :name_prefix => 'account' do
    resource :credit_card, :controller => "saasaparilla/credit_card"
    resource :contact_info, :controller => "saasaparilla/contact_info"
    resource :billing_history, :controller => "saasaparilla/billing_history" 
  end
  
  
  
end