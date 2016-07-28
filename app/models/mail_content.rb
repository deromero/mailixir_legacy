class MailContent < ApplicationRecord
  belongs_to :campaign

  validates :html_content, :text_content, presence:true
  validates_presence_of :campaign

end
