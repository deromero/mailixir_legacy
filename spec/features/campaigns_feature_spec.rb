require "rails_helper"

RSpec.describe 'campaigns' do
  let(:account) { create(:account_with_schema ) }
  let(:user) { account.owner }

  before do
    set_subdomain(account.subdomain)
    sign_in(user, subdomain: account.subdomain)
    visit root_path
  end

  describe 'list of items' do
    let(:client) { create(:client) }

    it 'shows a list of campaigns' do
      created_campaigns = create_list(:campaign, 10, client: client)

      click_on "Campaigns"

      campaign_ids = page.all('table#campaigns td.campaign_id').map(&:text)
      expect(campaign_ids).not_to be_empty
      expect(campaign_ids.size).to eq(10)
    end

  end

  describe 'when a user creates a campaign' do

    before(:each) do
      @created_clients = create_list(:client, 10)
      visit campaigns_path
      click_on "Create a campaign"
    end

    it "should success" do

      fill_in "Name", with: "My first campaign"
      fill_in "Subject", with: "Campaign Subject"
      fill_in "From email", with: "from@campaign.com"
      fill_in "From name", with: "From Name"
      fill_in "Reply to", with: "reply_to@campaign.com"
      fill_in "Send report to", with: "report@campaign.com"

      selected_client = @created_clients[0]
      select selected_client.name, from: "Client"

      click_on  "Create Campaign"

      expect(page).to have_content "My first campaign"
      expect(page).to have_content "Campaign My first campaign successfully created!"

    end

    it "should generic unsuccess" do

      fill_in "Name", with: "My first campaign"
      fill_in "Subject", with: "Campaign Subject"
      fill_in "From email", with: ""
      fill_in "From name", with: ""
      fill_in "Reply to", with: ""
      fill_in "Send report to", with: ""

      click_on  "Create Campaign"

      expect(page).to have_css ".has-error"
    end

    it 'should not save without client' do
      fill_in "Name", with: "My first campaign"
      fill_in "Subject", with: "Campaign Subject"
      fill_in "From email", with: "from@campaign.com"
      fill_in "From name", with: "From Name"
      fill_in "Reply to", with: "reply_to@campaign.com"
      fill_in "Send report to", with: "report@campaign.com"

      click_on  "Create Campaign"

      expect(page).to have_css ".has-error"
      expect(page).to have_content "must exist"
    end

  end

  describe 'when a user creates a campaign from dashboard ' do

    before(:each) do
      @created_clients = create_list(:client, 10)
      visit root_path
      click_on "Create New Campaign"
    end

    it 'should create a campaign' do
      fill_in "Name", with: "My first campaign from dashboard index"
      fill_in "Subject", with: "Campaign Subject from dashboard index"
      fill_in "From email", with: "from@campaign.com"
      fill_in "From name", with: "From Name"
      fill_in "Reply to", with: "reply_to@campaign.com"
      fill_in "Send report to", with: "report@campaign.com"

      selected_client = @created_clients[0]
      select selected_client.name, from: "Client"

      click_on  "Create Campaign"

      expect(page).to have_content "My first campaign from dashboard index"
      expect(page).to have_content "Campaign My first campaign from dashboard index successfully created!"


    end
  end

end
