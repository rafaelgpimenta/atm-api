Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace :v1 do
    resource :accounts, only: [] do
      get 'my'
    end
    resources :transactions, except: [:update, :destroy]
  end

  resource :auth, path: '', only: [] do
    post 'sign_up'
    post 'sign_in'
    post 'sign_out'
    post 'refresh'
  end
end
