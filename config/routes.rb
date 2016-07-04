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
    resources :campaigns, only: [:new, :create, :show]
    resources :clients, only: [:index, :new, :create, :show]
  end

  constraints(SubdomainBlankConstraint) do
    root 'welcome#index'
    resources :accounts, only: [:new, :create, :show]
  end



end
