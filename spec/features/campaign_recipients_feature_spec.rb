require 'rails_helper'

RSpec.describe 'campaign recipients' do
  let(:account) { create(:account_with_schema ) }
  let(:user) { account.owner }
  let(:client) { create(:client) }

  before do
    set_subdomain(account.subdomain)
    sign_in(user, subdomain: account.subdomain)
    visit root_path
  end

  describe 'create recipients' do
    before(:each) do
      @subscription_lists = create_list(:subscription_list, 10, client: client)
      @campaign =  create(:campaign, client: client)
      @content = create(:mail_content, campaign: @campaign)
      visit campaign_path @campaign
      click_on 'Define Recipients'
    end

    it 'can create with success' do
      expect(page).to have_current_path(new_recipient_path(:campaign => @campaign))

      check @subscription_lists[0].name
      check @subscription_lists[4].name
      check @subscription_lists[7].name

      click_on 'Save Recipients'

      expect(@campaign.assigned_subscription_lists).to eq(@subscription_lists[0].id+","+@subscription_lists[4].id+","+@subscription_lists[7].id)
      expect(page.current_path).to eq(build_campaign_path(@campaign))
      expect(page).to have_content("Recipients successfully created!")

    end

    it 'cannot create because validation' do
    end

  end


end
