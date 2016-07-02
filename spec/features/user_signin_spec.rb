require 'rails_helper'

RSpec.feature "User signin in" do

  background do
    @user = create(:user)
  end

  scenario "should success" do
    sign_in @user

    expect(page).to have_content @user.email
  end

  scenario "should unsuccess" do
    visit new_user_session_path
    fill_in "Email", with: "wrong@email.com"
    fill_in "Password", with: "wrongpassword"
    click_on "Log in"

    expect(page).not_to have_content @user.email

  end
end
