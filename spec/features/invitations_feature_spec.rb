require 'rails_helper'

RSpec.describe 'invitations' do
  let(:account) { create(:account_with_schema )}
  let(:user) { account.owner }

  before do
    set_subdomain(account.subdomain)
    sign_in(user, subdomain: account.subdomain)
    visit users_path
  end

  it 'shows the owner in the authorized users list' do
    expect(page).to have_content user.name
    expect(page).to have_content user.email
    expect(page).to have_selector '.glyphicon-ok'
  end

  it 'validates email' do
    fill_in "Email", with: "wrong"
    click_button "Invite User"

    expect(page).to have_content 'Send Invitation'
    expect(page).to have_content 'invalid'
  end

  describe 'when user is invited' do
    before do
      fill_in "Email", with: "user@email.com"
      click_button "Invite User"
    end

    it 'shows invitation' do
      expect(page).to have_content 'invitation email has been sent'
      expect(page).to have_content 'user@email.com'
      expect(page).to have_content 'Invitation pending'
    end

    context 'user accepts invitation' do
      before do
        fill_in "Email", with: "email@email.com"
        click_button "Invite User"

        click_link 'Sign out'

        open_email 'email@email.com'
        visit_in_email 'Accept invitation'

        fill_in "Name", with: "Invited User"
        fill_in "Password", with: "password"
        fill_in "Password confirmation", with: "password"

        click_button "Create Account"
      end

      it 'confirms account creation' do
        expect(page).to have_content "Your account was set successfully. You are now signed in."
      end

      it 'shows a checkmark on the users page' do
        visit users_path
        within('tr', text: 'Invited User') do
          expect(page).to have_selector '.glyphicon'
        end
      end

    end
  end
end
