require 'rails_helper'

RSpec.describe Client, type: :model do
  it "has a valid factory" do
    client = build(:client)
    expect(client).to be_valid
  end

  it 'is invalid without a name' do
    client = build(:client, name: nil)
    expect(client).not_to be_valid
  end

  it 'is invalid without a description' do
    client = build(:client, description: nil)
    expect(client).not_to be_valid
  end
end
