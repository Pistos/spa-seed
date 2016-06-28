require 'spec_helper'

describe 'Things: Delete', :type => :feature, js: true do
  context 'given a signed-in user' do
    include_context 'given a signed-in user'

    context 'given some things' do
      let(:name1) { 'particular name 1' }
      let(:name2) { 'particular name 2' }
      let!(:thing1) { FactoryGirl.create(:thing, name: name1) }
      let!(:thing2) { FactoryGirl.create(:thing, name: name2) }

      scenario 'deleting things' do
        visit "#{TEST_SERVER}!#/home"

        expect(page).to have_content(name1)
        expect(page).to have_content(name2)

        click_button 'delete', :match => :first

        expect(page).not_to have_content(name1)
        expect(page).to have_content(name2)

        click_button 'delete', :match => :first

        expect(page).not_to have_content(name1)
        expect(page).not_to have_content(name2)
      end
    end
  end
end
