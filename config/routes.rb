Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  # get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
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
