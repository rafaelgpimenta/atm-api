Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace :v1 do
    resources :accounts
    resources :customers
    resources :transactions
  end

  post 'sign_up', to: 'auth#sign_up'
  post 'sign_in', to: 'auth#sign_in'
  post 'sign_out', to: 'auth#sign_out'
  post 'refresh', to: 'auth#refresh'
end
