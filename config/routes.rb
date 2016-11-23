Rails.application.routes.draw do
  root "static_pages#home"

  namespace :admin do
    resources :categories
    resources :users, only: [:index, :destroy]
  end

  get  "/signup", to: "users#new"
  post "/signup", to: "users#create"
  get  "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  resources :categories
  resources :users
  get "/:page", to: "static_pages#show"
end
