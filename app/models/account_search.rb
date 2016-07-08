class AccountSearch
  include ActiveModel::Model

  attr_accessor :subdomain
  validates :subdomain, presence: true

end
