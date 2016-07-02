require 'rails_helper'

RSpec.describe 'User signing up' do

  scenario "should success" do
    visit new_user_registration_path
    fill_in "Username", with: "Example user"
    fill_in "Email", with: "example@mail.com"
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"

    click_on "Sign up"

    expect(page).to have_content "example@mail.com"

  end

  scenario "should unsuccess" do
    visit new_user_registration_path
    fill_in "Email", with: "example@mail.com"
    fill_in "Password", with: ""
    fill_in "Password confirmation", with: ""

    click_on "Sign up"

    expect(page).to have_content "error"
  end

end

