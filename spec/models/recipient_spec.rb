require 'rails_helper'

RSpec.describe Recipient, type: :model do
  let(:client) { create(:client) }
  let(:campaign) { create(:campaign, client: client) }
  let(:recipient) { create(:recipient, campaign: campaign) }


  it "has a valid factory" do
    expect(recipient).to be_valid
  end

  describe 'validations' do

    it { should validate_presence_of :email }
    it { should validate_presence_of :name }

  end

  describe 'associations' do
    it{ should belong_to :campaign }
  end


end
