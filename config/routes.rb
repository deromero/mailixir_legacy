class SubdomainPresent
  def self.matches?(request)
    request.subdomain.present?
  end
end

class SubdomainBlank
  def self.matches?(request)
    request.subdomain.blank?
  end
end

Rails.application.routes.draw do
  constraints(SubdomainPresent) do
    root 'dashboard#index', as: :subdomain_root
    devise_for :users
    resources :campaigns, only: [:new, :create, :show]
    resources :clients, only: [:new, :create, :show]
  end

  constraints(SubdomainBlank) do
    root 'welcome#index'
    resources :accounts, only: [:new, :create, :show]
  end



end
