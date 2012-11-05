Rails.application.routes.draw do
  
  namespace "admin", :module => 'saasaparilla/admin' do
    resources :plans
    resources :subscriptions do
      get 'cancel', :on => :member
      get 'toggle_no_charge', :on => :member
      resources :transactions, :only => [:index]
    end
  end
  
  resource :subscription, :controller => "saasaparilla/subscription" do 
    get 'reactivate', :on => :member
  end
  
  namespace 'subscription', :module => "saasaparilla" do
    resources :payments
    resource :credit_card, :controller => "credit_card"
    resource :plan,  :only => [:edit, :update]
    resource :contact_info, :controller => "contact_info"
    resource :billing_history, :controller => "billing_history"
    resources :invoices
  end
  
  
  
end