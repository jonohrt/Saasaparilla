Rails.application.routes.draw do
  resources :plans, :controller => "saasaparilla/plans"
  
  resources :accounts, :controller => "saasaparilla/accounts" do
    resources :credit_cards, :controller => "saasaparilla/credit_cards"  
  end
  
  
end