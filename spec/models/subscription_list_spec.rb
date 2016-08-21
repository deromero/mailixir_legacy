require 'rails_helper'

RSpec.describe SubscriptionList, type: :model do
  let(:client) { create(:client) }
  let(:subscription_list) { create(:subscription_list, client: client) }

  it 'has a valid factory' do
    expect(subscription_list).to be_valid
  end

  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :list_type }
    it { should validate_presence_of :client }
  end

  describe 'associations' do
    it { should belong_to :client }
    it { should have_many :subscribers }
  end


end
