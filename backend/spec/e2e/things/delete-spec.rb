require 'spec_helper'

describe 'Things: Delete', :type => :feature, js: true do
  context 'given a signed-in user' do
    include_context 'given a signed-in user'

    context 'given some things' do
      let!(:thing1) { FactoryGirl.create(:thing, name: 'particular name 1') }
      let!(:thing2) { FactoryGirl.create(:thing, name: 'particular name 2') }

      scenario 'deleting things' do
        visit 'http://localhost:3010/#!/home'

        expect(page).to have_content(thing1.name)
        expect(page).to have_content(thing2.name)

        click_button 'delete', :match => :first

        expect(page).not_to have_content(thing1.name)
        expect(page).to have_content(thing2.name)

        click_button 'delete', :match => :first

        expect(page).not_to have_content(thing1.name)
        expect(page).not_to have_content(thing2.name)
      end
    end
  end
end
