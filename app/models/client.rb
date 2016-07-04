class Client < ApplicationRecord
  has_many :campaigns, dependent: :destroy
  accepts_nested_attributes_for :campaigns

  validates :name, :contact_name, :contact_email, presence: true

end
