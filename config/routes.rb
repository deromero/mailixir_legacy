class SubdomainPresentConstraint
  def self.matches?(request)
    request.subdomain.present?
  end
end

class SubdomainBlankConstraint
  def self.matches?(request)
    request.subdomain.blank?
  end
end

Rails.application.routes.draw do
  constraints(SubdomainPresentConstraint) do
    root 'dashboard#index', as: :subdomain_root
    devise_for :users
    resources :users, only: [:index]
    resources :clients
    resources :campaigns, only: [:index, :new, :create, :show, :edit, :update]

    get 'campaigns/build/:id', to: 'campaigns#build', as: 'build_campaign'
    get 'campaigns/schedule/:id', to: 'campaigns#schedule', as: 'schedule_campaign'

    resources :mail_contents, only: [:new, :create, :edit, :update, :destroy]
    resources :recipients, only: [:new, :create, :edit, :update, :destroy]
    resources :subscription_lists, only: [:index, :show, :new, :create, :edit, :update, :destroy]

  end

  constraints(SubdomainBlankConstraint) do
    root 'welcome#index'
    resources :accounts, only: [:new, :create, :show]

    get '/signin', to: 'accounts#signin', as: 'sign_in'
    post '/search_account', to: 'accounts#search', as: 'search_account'
  end
end
