require 'spec_helper'

describe 'Things: Create', :type => :feature, js: true do
  context 'given a signed-in user' do
    include_context 'given a signed-in user'

    let(:name) { 'thing name' }
    let(:description) { 'description of the thing' }

    scenario 'creating things' do
      visit "#{TEST_SERVER}!#/home"

      expect(page).not_to have_content(name)
      expect(page).not_to have_content(description)

      fill_in 'name', with: name
      fill_in 'description', with: description

      click_button 'Create'

      expect(page).to have_content(name)
      expect(page).to have_content(description)
    end
  end
end
