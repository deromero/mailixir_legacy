class Recipient < ApplicationRecord
  belongs_to :campaign

  validates :email, :name, presence:true

  validates_presence_of :campaign
end
