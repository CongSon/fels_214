Rails.application.routes.draw do
  resources :users
  root "static_pages#home"

  get "/:page", to: "static_pages#show"
end
