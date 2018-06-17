Rails.application.routes.draw do
  root 'tables#index'
  namespace :v1 do
    resources :tables
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
