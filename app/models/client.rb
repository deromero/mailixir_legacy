class Client < ApplicationRecord
  has_many :campaigns, dependent: :destroy
  has_many :subscription_lists, dependent: :destroy
  accepts_nested_attributes_for :campaigns, :subscription_lists

  validates :name, :contact_name, :contact_email, presence: true

end
