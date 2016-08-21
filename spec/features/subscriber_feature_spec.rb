require 'rails_helper'

RSpec.describe 'subscribers' do
  let(:account) { create(:account_with_schema ) }
  let(:user) { account.owner }

  before do
    set_subdomain(account.subdomain)
    sign_in(user, subdomain: account.subdomain)
    visit root_path
  end

  describe 'items on list' do
    before do
      @client = create(:client)
      @subscription_list = create(:subscription_list, client: @client)
      @subscribers = create_list(:subscriber, 45, subscription_list: @subscription_list)
      visit subscription_list_path(@subscription_list, :client => @client)
    end

    it 'can be items on list detail page' do

      expect(page).to have_current_path(subscription_list_path(@subscription_list, :client => @client))
      subscriber_ids = page.all('table#subscribers td.subscriber_id').map(&:text)
      expect(subscriber_ids).not_to be_empty
      expect(subscriber_ids.size).to eq(45)

    end
  end

  describe 'import / create items' do
    before do
      @client = create(:client)
      @subscription_list = create(:subscription_list, client: @client)
      visit subscription_list_path(@subscription_list, :client => @client)
      click_on 'Add subscribers'
    end

    it 'goes to add page' do
      expect(page).to have_current_path(add_subscribers_path(:list => @subscription_list, :client=>@client))
    end

    context 'add subscribers from string' do
      it 'add success' do
        click_on 'Manually add'
        fill_in "manual_subscribers_importer_csv_string", with: subscriber_list
        click_on "Add subscribers"

        subscriber_ids = page.all('table#subscribers td.subscriber_id').map(&:text)
        expect(subscriber_ids).not_to be_empty
        expect(subscriber_ids.size).to eq(100)
        expect(page).to have_content("Imported 100 subscribers successfully!")

      end

      it 'add unsuccess because validation' do
        click_on 'Manually add'
        fill_in "manual_subscribers_importer_csv_string", with: ""
        click_on "Add subscribers"

        expect(page).to have_css(".error")
      end

    end

    context 'import subscribers from uploaded file' do

      it 'can import from a file' do

      end
    end


  end

  describe 'clear items' do
    before do
      @client = create(:client)
      @subscription_list = create(:subscription_list, client: @client)
      @subscribers = create_list(:subscriber, 1000, subscription_list: @subscription_list)
      visit subscription_list_path(@subscription_list, :client => @client)
    end

    it 'can clear all subscribers for a list' do
      click_on 'Clear list'

      expect(page).to have_content("List successfully cleared!")

      subscriber_ids = page.all('table#subscribers td.subscriber_id').map(&:text)
      expect(subscriber_ids).to be_empty
    end

  end

end
