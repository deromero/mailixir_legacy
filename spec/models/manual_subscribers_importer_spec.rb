require 'rails_helper'

RSpec.describe ManualSubscribersImporter do

  describe 'validations' do
    it { should validate_presence_of :csv_string }
  end

end
