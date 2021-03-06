require_relative 'acceptance_helper'

feature 'User sign out', %q{
  To finish session
  user need to sign out
} do

  given(:user) { create(:user) }

  scenario 'Authenticated user try to sign out' do
    sign_in(user)
    click_on 'Sign out'

    expect(page).to have_content 'Signed out successfully'
    expect(page).to have_content 'Sign in'
  end

  scenario 'Non-Authenticated user try to sign out' do
    visit questions_path

    expect(page).to have_no_content 'Sign out'
  end
end
