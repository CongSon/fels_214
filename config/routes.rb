Rails.application.routes.draw do
  root "static_pages#home"

  namespace :admin do
    resources :categories
  end

  resources :users

  get "/:page", to: "static_pages#show"
end
