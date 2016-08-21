class ManualSubscribersImporter
  include ActiveModel::Model

  attr_accessor :csv_string
  validates :csv_string, presence: true
end
