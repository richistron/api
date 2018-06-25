Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # root 'tables#index'
  namespace :v1 do
    resources :tables
    resources :accounts
    resources :account_items
    resources :products
    resources :tenants
  end
end
