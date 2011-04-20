Rails.application.routes.draw do
  
  scope '/admin', :name_prefix => 'admin' do
    resources :plans, :controller => "saasaparilla/admin/plans"
    resources :subscriptions, :controller => "saasaparilla/admin/subscriptions"
  end
  
  resource :subscription, :controller => "saasaparilla/subscription" do 
    get 'reactivate', :on => :member
  end
  
  scope '/subscription', :name_prefix => 'subscription' do
    resources :payments, :controller => "saasaparilla/payments" 
    resource :credit_card, :controller => "saasaparilla/credit_card"
    resource :plan, :controller => "saasaparilla/plans", :only => [:edit, :update]
    resource :contact_info, :controller => "saasaparilla/contact_info"
    resource :billing_history, :controller => "saasaparilla/billing_history" 
    resources :invoices, :controller => "saasaparilla/invoices"
  end
  
  
  
end