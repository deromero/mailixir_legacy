class Campaign < ApplicationRecord
  validates :name, :subject, :from_email,
            :from_name, :reply_to, :status, presence: true

  enum status: { draft: 0, ready_to_send: 1,
                          sent: 2, failed: 3, retry: 4,
                          retrying: 5, sending: 6, cancelled: 7 }
end
