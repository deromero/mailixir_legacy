require 'rails_helper'

RSpec.describe Campaign, type: :model do
  let(:client) { create(:client) }
  let(:campaign) { create(:campaign, client: client) }


  it "has a valid factory" do
    expect(campaign).to be_valid
  end

  describe 'validations' do

    it { should validate_presence_of :name }
    it { should validate_presence_of :subject }
    it { should validate_presence_of :from_email }
    it { should validate_presence_of :from_name }
    it { should validate_presence_of :status }

    it 'status should be draft' do
      expect(campaign.status).to eq('draft')

    end

  end

  describe 'associations' do
    it{ should belong_to :client }
    it { should have_one :mail_content }
    it { should have_many :recipients }
  end

  describe 'control expressions' do
    before(:each) do
      @campaign = create(:campaign, client: client)
    end

    it 'is draft' do
      expect(campaign.is_draft?).to eq(true)
    end

    it 'is editable' do
     expect(campaign.is_editable?).to eq(true)
    end

    it 'has content defined' do
      @content = create(:mail_content, campaign: @campaign)

      expect(@campaign.mail_content).to eq(@content)
      expect(@campaign.has_content?).to eq(true)
    end

    it 'has recipients defined' do
      @recipients = create_list(:recipient, 10, campaign: @campaign)

      expect(@campaign.recipients.length).to eq(10)
      expect(@campaign.has_recipients?).to eq(true)
    end

    it 'is schedule defined' do
      @campaign.scheduled_on = '01/01/2025 15:20'

      expect(@campaign.has_schedule?).to eq(true)
    end



  end

end
