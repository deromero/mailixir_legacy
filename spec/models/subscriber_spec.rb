require 'rails_helper'

RSpec.describe Subscriber, type: :model do
  let(:client) { create(:client) }
  let(:subscription_list) { create(:subscription_list, client: client) }
  let(:subscriber) { build(:subscriber, subscription_list: subscription_list) }

  it 'has a valid factory' do
    expect(subscriber).to be_valid
  end

  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :email }
    it { should validate_presence_of :subscription_list }
  end

  describe 'associations' do
    it {should belong_to :subscription_list}
  end

end
