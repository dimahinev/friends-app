Rails.application.routes.draw do
  devise_for :users
  resources :friends
  get "home/about"
  # friends controller -> index method
  root "friends#index"
end
