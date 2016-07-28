require 'rails_helper'

RSpec.describe 'clients' do
  let(:account) { create(:account_with_schema ) }
  let(:user) { account.owner }

  before do
    set_subdomain(account.subdomain)
    sign_in(user, subdomain: account.subdomain)
    visit root_path
  end

  it 'shows a list of clients' do
    created_clients = create_list(:client, 5)

    click_on "Clients"

    client_ids = page.all('table#clients td.client_id').map(&:text)
    expect(client_ids).not_to be_empty
    expect(client_ids.size).to eq(5)

  end

  describe 'when user creates a client' do
    before do
      visit clients_path
      click_on "Create a client"
    end

    it "should success" do

      fill_in "Name", with: "My first client name"
      fill_in "Contact name", with: "first client contact name"
      fill_in "Contact email", with: "client@email.com"
      select  "Ecuador", :from => "Country code"
      fill_in "Time zone", with: "-5"

      click_on "Create Client"
      expect(page).to have_content "My first client name"
      expect(page).to have_content "Client My first client name successfully created!"
    end

    it "should unsuccess" do
      fill_in "Name", with: "My second client name"
      fill_in "Contact name", with: ""
      fill_in "Contact email", with: ""
      select  "Ecuador", :from => "Country code"
      fill_in "Time zone", with: "-5"

      click_on "Create Client"
      expect(page).to have_css ".has-error"
    end
  end

  describe 'when user view client details' do
    before do
      @created_clients = create_list(:client, 10)
      @selected_client = @created_clients[5]
      @created_campaigns = create_list(:campaign, 10, client: @selected_client)

      visit clients_path
    end

    it 'should view a client details' do
      find('tr',text: @selected_client.name).click_link("Details")

      expect(page).to have_content(@selected_client.name)
      expect(current_path).to eq(client_path(@selected_client))
    end

    it 'should view a list of client campaigns' do
      find('tr',text: @selected_client.name).click_link("Details")

      campaign_ids = page.all('table#campaigns td.campaign_id').map(&:text)
      expect(campaign_ids).not_to be_empty
      expect(campaign_ids.size).to eq(10)
    end

    describe 'when a user edit a client' do

      before do
        find('tr',text: @selected_client.name).click_link("Edit")
      end

      it 'should successfully edit' do
        fill_in "Name", with: "The updated client name"
        fill_in "Contact name", with: "The updated client contact name"
        fill_in "Contact email", with: "updated@email.com"
        select  "Italy", :from => "Country code"
        fill_in "Time zone", with: "+1"

        click_on "Update Client"

        expect(page).to have_content("The updated client name")
        expect(page).to have_content "The updated client name successfully updated!"
      end

      it 'should not to edit for validation issues' do


      end

    end

  end



end
