require 'rails_helper'
RSpec.describe 'campaign content' do
  let(:account) { create(:account_with_schema ) }
  let(:user) { account.owner }
  let(:client) { create(:client) }

  before do
    set_subdomain(account.subdomain)
    sign_in(user, subdomain: account.subdomain)
    visit root_path
  end

  describe 'create content' do
    before(:each) do
      @campaign =  create(:campaign, client: client)
      visit campaign_path @campaign
      click_on 'Define Content'
    end

    it 'can create with success'  do
      expect(page).to have_current_path(new_mail_content_path(:campaign => @campaign))

      fill_in "mail_content_html_content", with: "text with <i>html</i>"
      fill_in "mail_content_text_content", with: "text with plain text"

      click_on 'Create Mail content'

      expect(page.current_path).to eq(build_campaign_path(@campaign))
      expect(page).to have_content("Content successfully created!")
    end

    it 'cannot create because validation' do

      fill_in "mail_content_html_content", with: "text with <i>html</i>"
      fill_in "mail_content_text_content", with: ""

      click_on 'Create Mail content'

      expect(page).to have_css ".has-error"

    end

  end

  describe 'edit content' do
    before(:each) do
      @campaign = create(:campaign, client: client)
      @content = create(:mail_content, campaign: @campaign)

      visit campaign_path @campaign

      click_on 'edit content'
    end

    it 'can edit with success' do
      expect(page).to have_current_path(edit_mail_content_path(@content, :campaign => @campaign))

      fill_in "mail_content_html_content", with: "Fake Test Fake html text"
      fill_in "mail_content_text_content", with: "Fake Test Fake text text"

      click_on 'Update Mail content'

      expect(page.current_path).to eq(build_campaign_path(@campaign))
      expect(page).to have_content("Content successfully updated!")
    end

    it 'cannot edit because validation' do
      fill_in "mail_content_html_content", with: ""
      fill_in "mail_content_text_content", with: ""

      click_on 'Update Mail content'

      expect(page).to have_css ".has-error"
    end

  end

end
