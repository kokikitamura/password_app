Rails.application.routes.draw do
  resources :users
  get "users/:id/withdraw", to: "users#withdraw"
  get    "/login",   to: "sessions#new"
  post   "/login",   to: "sessions#create"
  delete "/logout",  to: "sessions#destroy"
  resources :passwords
end
