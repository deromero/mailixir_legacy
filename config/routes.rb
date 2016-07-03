Rails.application.routes.draw do
  root 'welcome#index'

  devise_for :users
  resources :campaigns, only: [:new, :create, :show]
  resources :clients, only: [:new, :create, :show]
  resources :accounts, only: [:new, :create, :show]

end
