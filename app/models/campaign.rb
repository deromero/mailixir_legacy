class Campaign < ApplicationRecord
  validates :name, :description, presence: true
end
