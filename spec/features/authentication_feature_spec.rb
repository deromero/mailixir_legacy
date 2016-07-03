require 'rails_helper'

RSpec.describe 'user authentication' do

  it 'allows signin with valid credentials' do
    sign_in(create(:user))
    expect(page).to have_content('Signed in successfully')
  end

  it 'does not allow signin whit invalid credentials' do
    sign_in(create(:user),password: 'wrong password')
    expect(page).to have_content('Invalid Email or password')
  end

  it 'allows user to sign out' do
    sign_in(create(:user))

    visit root_path
    click_link 'Sign out'

    expect(page).to have_content('Signed out successfully')
  end



end
