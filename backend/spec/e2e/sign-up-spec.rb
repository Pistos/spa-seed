require 'spec_helper'

describe 'Signing Up', :type => :feature, js: true do
  scenario 'signing up' do
    visit TEST_SERVER

    click_link 'Sign Up'

    fill_in 'username', with: 'newuser'
    fill_in 'password', with: 'somepassword'

    click_button 'Sign Up'

    expect(page).not_to have_button('Sign Up')
    expect(page).to have_button('Sign In')
  end
end

