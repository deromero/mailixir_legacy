class SubscriptionList < ApplicationRecord
  has_many :subscribers, dependent: :destroy
  belongs_to :client

  validates :name, :list_type, :client,  presence: true

  enum list_type: { flat: 0, extended: 1 }
end
