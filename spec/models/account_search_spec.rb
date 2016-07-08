require "rails_helper"

RSpec.describe AccountSearch do

  describe 'validations' do
    it { should validate_presence_of :subdomain }
  end

end
