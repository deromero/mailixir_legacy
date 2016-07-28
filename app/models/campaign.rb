class Campaign < ApplicationRecord
  has_one :mail_content, dependent: :destroy
  has_many :recipients, dependent: :destroy
  belongs_to :client

  validates :name, :subject, :from_email,
            :from_name, :reply_to, :status, presence: true

  validates_presence_of :client

  enum status: { draft: 0, ready_to_send: 1,
                          sent: 2, failed: 3, retry: 4,
                          retrying: 5, sending: 6, cancelled: 7 }


  def is_draft?
    self.status == 'draft'
  end

  def is_editable?
    self.status == 'draft' ||
    self.status == 'ready_to_send' ||
    self.status == 'retry'
  end

  def has_content?
    !self.mail_content.nil?
  end

  def has_recipients?
    !self.recipients.nil? &&
    self.recipients.length > 0

  end

  def has_schedule?
    !self.scheduled_on.nil?
  end



end
