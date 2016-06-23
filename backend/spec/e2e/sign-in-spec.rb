require 'spec_helper'

describe 'Signing In', :type => :feature, js: true do
  context 'given a user' do
    let(:username) { 'joe' }
    let(:password) { 'abcd' }
    let(:user) {
      FactoryGirl.create(:user, username: username).tap { |u|
        u.password = password
        u.save
      }
    }

    scenario 'signing in' do
      expect(ProjectName::Model::User[user.id]).not_to be_nil

      visit 'http://localhost:3010/'

      expect(page).not_to have_text('Home')

      click_link 'Sign In'

      fill_in 'username', with: username
      fill_in 'password', with: password

      click_button 'Sign In'

      expect(page).not_to have_text('Sign In')
      expect(page).to have_text('Home')
    end
  end
end
