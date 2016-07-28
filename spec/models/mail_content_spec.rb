require 'rails_helper'

RSpec.describe MailContent, type: :model do
  let(:client) { create(:client) }
  let(:campaign) { create(:campaign, client: client) }
  let(:mail_content) { create(:mail_content, campaign: campaign) }


  it "has a valid factory" do
    expect(mail_content).to be_valid
  end

  describe 'validations' do

    it { should validate_presence_of :html_content }
    it { should validate_presence_of :text_content }

  end

  describe 'associations' do
    it{ should belong_to :campaign }
  end

end
