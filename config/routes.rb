Rails.application.routes.draw do
  root 'home#show'

  resources :campaigns, only: [:new, :create, :show]
  resources :clients, only: [:new, :create, :show]

end
