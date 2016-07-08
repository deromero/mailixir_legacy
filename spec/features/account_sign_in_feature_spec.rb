require "rails_helper"

RSpec.describe 'account sign in' do
  let(:account) { create(:account_with_schema  ) }
  let(:user) { account.owner }

  before do

    visit root_url(subdomain: false)
  end

  it 'should sign in with account subdomain' do
    click_on "Sign in"

    fill_in "Subdomain", with: account.subdomain

    click_on "Log in"

    expect(page.current_url).to include(account.subdomain)
    expect(page).to have_content("Sign in")
    expect(page).to have_content("Please use the form below to sign in to your account")

  end

  it 'should not permit sign in without valid subdomain' do
    click_on "Sign in"

    fill_in "Subdomain", with: 'random-noexists-subdomain'

    click_on "Log in"

    expect(page.current_url).not_to include(account.subdomain)
    expect(page).to have_content("account does not exists!")

  end

end
