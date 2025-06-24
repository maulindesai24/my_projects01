Rails.application.routes.draw do
  get "comments/index"
  get "comments/new"
  get "comments/create"
  get "comments/show"
  get "comments/destroy"
  namespace :admin do
    get "dashboard", to: "dashboard#index"
    resources :users, only: [:index]
    resources :posts
    resources :tasks
  end
  
  devise_for :users

  resources :posts do
    resources :comments, only: [:create, :destroy]
  end
  resources :tasks do
    resources :comments, only: [:create, :destroy]
  end
  get "home/index"
  get "up" => "rails/health#show", as: :rails_health_check
  root "home#index"
end
