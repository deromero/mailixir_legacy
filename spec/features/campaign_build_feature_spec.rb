require 'rails_helper'

RSpec.describe 'campaign build' do
  let(:account) { create(:account_with_schema ) }
  let(:user) { account.owner }
  let(:client) { create(:client) }

  before do
    set_subdomain(account.subdomain)
    sign_in(user, subdomain: account.subdomain)
    visit root_path
  end

  describe 'properties' do
    before(:each) do
      @campaign =  create(:campaign, client: client)
      @created_clients = create_list(:client, 10)
    end

    it 'show build page for campaign in draft' do
      visit campaign_path(@campaign)

      expect(page.current_path).to eq(build_campaign_path(@campaign))
      expect(page).to have_content(@campaign.name)
    end

    it 'could go to edit properties form page' do
      visit campaign_path(@campaign)
      click_on 'edit properties'
      expect(page.current_path).to eq(edit_campaign_path(@campaign))
    end

    it 'properties can be edited with success' do
      visit edit_campaign_path(@campaign)

      fill_in "Name", with: "My updated campaign"
      fill_in "Subject", with: "Updated Campaign Subject"
      fill_in "From email", with: "updated_from@campaign.com"
      fill_in "From name", with: "Updated From Name"
      fill_in "Reply to", with: "updated_reply_to@campaign.com"
      fill_in "Send report to", with: "updated_report@campaign.com"

      selected_client = @created_clients[3]
      select selected_client.name, from: "Client"

      click_on "Update Campaign"

      expect(page).to have_content "My updated campaign"
      expect(page).to have_content "Campaign My updated campaign successfully updated!"
      expect(page.current_path).to eq(build_campaign_path(@campaign))
    end

  end

end
