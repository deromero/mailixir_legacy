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

  it 'is invalid without a subject' do
    campaign = build(:campaign, subject: nil)
    expect(campaign).not_to be_valid
  end

  it 'is invalid without a from email' do
    campaign = build(:campaign, from_email: nil)
    expect(campaign).not_to be_valid
  end

  it 'is invalid without a from name' do
    campaign = build(:campaign, from_name: nil)
    expect(campaign).not_to be_valid
  end

  it 'is invalid without a reply to email' do
    campaign = build(:campaign, reply_to: nil)
    expect(campaign).not_to be_valid
  end

  it 'is invalid without a status' do
    campaign = build(:campaign, status: nil)
    expect(campaign).not_to be_valid
  end

end
