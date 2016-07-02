Rails.application.routes.draw do
  devise_for :users
  root 'home#show'

  resources :campaigns, only: [:new, :create, :show]
  resources :clients, only: [:new, :create, :show]

end
