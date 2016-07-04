require "rails_helper"

RSpec.describe 'clients' do
  let(:account) { create(:account_with_schema ) }
  let(:user) { account.owner }

  before do
    set_subdomain(account.subdomain)
    sign_in(user, subdomain: account.subdomain)
    visit root_path
  end

  it 'shows a list of campaigns' do
    created_campaigns = create_list(:campaign, 5)

    click_on "Campaigns"

    campaign_ids = page.all('table#campaigns td.campaign_id').map(&:text)
    expect(campaign_ids).not_to be_empty
    expect(campaign_ids.size).to eq(5)

  end

  describe 'when a user creates a campaign' do
    before do
      visit campaigns_path
      click_on "Create a campaign"
    end

    it "should sucess" do

      fill_in "Name", with: "My first campaign"
      fill_in "Subject", with: "Campaign Subject"
      fill_in "From email", with: "from@campaign.com"
      fill_in "From name", with: "From Name"
      fill_in "Reply to", with: "reply_to@campaign.com"
      fill_in "Send report to", with: "report@campaign.com"

      click_on  "Create Campaign"

      expect(page).to have_content "My first campaign"
      expect(page).to have_content "Campaign My first campaign successfully created!"

    end

    it "should unsucess" do

      fill_in "Name", with: "My first campaign"
      fill_in "Subject", with: "Campaign Subject"
      fill_in "From email", with: ""
      fill_in "From name", with: ""
      fill_in "Reply to", with: ""
      fill_in "Send report to", with: ""

      click_on  "Create Campaign"

      expect(page).to have_css ".has-error"
    end


  end

end
