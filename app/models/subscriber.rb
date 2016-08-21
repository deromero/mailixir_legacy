class Subscriber < ApplicationRecord
  belongs_to :subscription_list

  validates :name, :email, :subscription_list, presence: true

end
