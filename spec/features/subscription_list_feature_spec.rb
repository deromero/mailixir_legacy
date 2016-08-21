require 'rails_helper'

RSpec.describe 'subscription list' do
  let(:account) { create(:account_with_schema ) }
  let(:user) { account.owner }

  before do
    set_subdomain(account.subdomain)
    sign_in(user, subdomain: account.subdomain)
    visit root_path
  end

  describe 'list of items' do
    before do
      @client = create(:client)
      @subscriptions = create_list(:subscription_list, 15, client: @client)
    end

    it 'shows a list of subscriptions' do
      visit client_path(@client)
      click_on 'Subscription Lists'

      expect(page).to have_current_path(subscription_lists_path(:client => @client))

      subscription_ids  = page.all('table#subscriptions td.subscription_id').map(&:text)
      expect(subscription_ids).not_to be_empty
      expect(subscription_ids.size).to eq(15)
    end
  end

  describe 'see list details' do
    before do
      @client = create(:client)
      @subscriptions = create_list(:subscription_list, 15, client: @client)

      visit subscription_lists_path(:client => @client)
      @selected_subscription = @subscriptions[7]
    end

    it 'details page from list table' do
      find('tr', text: @selected_subscription.name).click_link("details")

      expect(page).to have_current_path(subscription_list_path(@selected_subscription,:client => @client))
      expect(page).to have_content(@selected_subscription.name)
    end

    it 'details page from url' do
      visit subscription_list_path(@selected_subscription, :client => @client)
      expect(page).to have_current_path(subscription_list_path(@selected_subscription,:client => @client))
      expect(page).to have_content(@selected_subscription.name)
    end

  end

  describe 'create list' do
    before do
      @client = create(:client)
    end

    it 'success' do
      visit client_path(@client)
      click_on 'Subscription Lists'

      click_on 'New Subscription List'


      expect(page).to have_current_path(new_subscription_list_path(:client=>@client))

      fill_in "Name", with: "List Name"
      select 'flat', from: "subscription_list_list_type"

      click_on 'Create Subscription list'

      expect(page).to have_current_path(subscription_lists_path(:client => @client))
      expect(page).to have_content("Subscription List successfully created!")
      expect(page).to have_content('List Name')
    end

    it 'not success because validation' do
      visit client_path(@client)
      click_on 'Subscription Lists'
      click_on 'New Subscription List'

      fill_in 'Name', with: ''

      click_on 'Create Subscription list'

      expect(page).to have_css('.has-error')
    end
  end

  describe 'edit list' do
    before do
      @client = create(:client)
      @subscriptions = create_list(:subscription_list, 15, client: @client)
      @selected_subscription = @subscriptions[9]
      visit subscription_list_path(@selected_subscription, :client => @client)
    end

    it 'edit with success' do
      click_on "Edit"

      fill_in "Name", with: "The new name"

      click_on "Update Subscription list"

      expect(page).to have_current_path(subscription_list_path(@selected_subscription, :client => @client))
      expect(page).to have_content("The new name")
      expect(page).to have_content("Subscription List successfully updated!")

    end

    it 'is invalid because validations' do
      click_on "Edit"

      fill_in "Name", with: ""

      click_on "Update Subscription list"
      expect(page).to have_css('.has-error')
    end


  end

end
