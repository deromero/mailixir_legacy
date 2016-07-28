class SubscriptionList < ApplicationRecord
  belongs_to :client

  validates :name, :list_type, presence: true

  enum list_type: { flat: 0, extended: 1 }
end
