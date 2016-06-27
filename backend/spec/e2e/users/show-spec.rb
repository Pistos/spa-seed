require 'spec_helper'

describe 'Users: Show', :type => :feature, js: true do
  context 'given a signed-in user' do
    include_context 'given a signed-in user'

    scenario "viewing one's own page" do
      visit "http://localhost:3010/#!/users/#{user.id}"
      sleep 3
      # TODO: This is just temporary until user record deltas are propagated with the DatabaseEvent system
      page.execute_script 'window.location.reload()'
      sleep 3

      expect(page).to have_content(user.username)
    end
  end
end
