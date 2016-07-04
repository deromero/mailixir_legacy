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




end
