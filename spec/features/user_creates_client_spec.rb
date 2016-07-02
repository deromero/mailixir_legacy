require "rails_helper"

RSpec.describe 'Creating client' do
  scenario "should success" do
      visit root_path
      click_on "Create a client"

      fill_in "Name", with: "My first client name"
      fill_in "Description", with: "first client description"

      click_on "Save"
      expect(page).to have_content "My first client name"
  end

  scenario "should unsucess" do
    visit root_path
    click_on "Create a client"

    fill_in "Name", with: "My second client"
    fill_in "Description", with: ""

    click_on  "Save"
    expect(page).to have_css ".error"
  end

end
