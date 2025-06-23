Rails.application.routes.draw do
  namespace :admin do
    get "dashboard", to: "dashboard#index"
    resources :users, only: [:index]
    resources :posts
    resources :tasks
  end
  
  devise_for :users
  resources :posts
  resources :tasks
  get "home/index"
  get "up" => "rails/health#show", as: :rails_health_check
  root "home#index"
end
