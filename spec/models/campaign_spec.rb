require 'rails_helper'

RSpec.describe Campaign, type: :model do
  it "has a valid factory" do
    campaign = build(:campaign)
    expect(campaign).to be_valid
  end

  it 'is invalid without a name' do
    campaign = build(:campaign, name: nil)
    expect(campaign).not_to be_valid
  end

  it 'is invalid without a description' do
    campaign = build(:campaign, description: nil)
    expect(campaign).not_to be_valid
  end


end
