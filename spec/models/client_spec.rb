require 'rails_helper'

RSpec.describe Client, type: :model do
  let(:client) { build(:client) }

  it "has a valid factory" do
    expect(client).to be_valid
  end

  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :contact_name }
    it { should validate_presence_of :contact_email }
  end

  describe 'associations' do
    #it { should has_many :campaigns }
  end

end
