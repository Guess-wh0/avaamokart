Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  root to: 'users#index'

  resources :products, :orders, only: [:index]
  resources :users, only: [:index] do
    member do
      post :create_order_history
      get :download_order_history
    end
  end
end
