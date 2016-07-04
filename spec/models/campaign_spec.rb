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
  end

end
