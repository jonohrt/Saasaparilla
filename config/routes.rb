Rails.application.routes.draw do
  resources :plans, :controller => "saasaparilla/plans"
  
  
  
  resource :subscription, :controller => "saasaparilla/subscription"
  
  scope '/subscription', :name_prefix => 'subscription' do
    resources :payments, :controller => "saasaparilla/payments" 
    resource :credit_card, :controller => "saasaparilla/credit_card"
    resource :contact_info, :controller => "saasaparilla/contact_info"
    resource :billing_history, :controller => "saasaparilla/billing_history" 
    resources :invoices, :controller => "saasaparilla/invoices"
  end
  
  
  
end