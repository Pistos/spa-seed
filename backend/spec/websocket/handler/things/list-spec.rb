require 'spec_helper'
require 'project-name/websocket/handler/things/list'

describe ProjectName::Websocket::Handler::Things::List do
  subject(:handler) {
    ProjectName::Websocket::Handler::Things::List.new(
      websocket: double("Websocket", send: nil),
      id: 1
    )
  }

  context 'given some things' do
    before do
      FactoryGirl.create :thing, name: 'thing1'
      FactoryGirl.create :thing, name: 'thing2'
    end

    describe '#respond' do
      it 'returns all the things' do
        response = handler.response

        expect(response.count).to eq 2
        expect(response[1]['name']).to eq 'thing2'
      end
    end
  end
end
