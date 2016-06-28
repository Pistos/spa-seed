require 'spec_helper'

describe 'Users: Show', :type => :feature, js: true do
  context 'given a signed-in user' do
    include_context 'given a signed-in user'

    scenario "viewing one's own page" do
      visit "#{TEST_SERVER}!#/users/#{user.id}"

      expect(page).to have_content(user.username)
    end
  end
end
