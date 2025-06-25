Rails.application.routes.draw do
  devise_for :users
  namespace :admin do
    get "dashboard", to: "dashboard#index"
    resources :users, only: [ :index ]
    resources :posts do
      resources :comments, only: [ :create, :destroy ]
    end
    resources :tasks
  end

  resources :likes, only: [ :create, :destroy ]

  resources :posts do
    resources :comments, only: [ :create, :destroy ]
  end
  resources :tasks do
    resources :comments, only: [ :create, :destroy ]
  end
  get "home/index"
  get "up" => "rails/health#show", as: :rails_health_check
  root "home#index"
end
