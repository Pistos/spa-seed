require 'spec_helper'
require 'project-name/websocket/handler/users/list'

describe ProjectName::Websocket::Handler::Users::List do
  subject(:handler) {
    ProjectName::Websocket::Handler::Users::List.new(
      websocket: double("Websocket", send: nil),
      websocket_message_id: 1
    )
  }

  context 'given some users' do
    let!(:user1) { FactoryGirl.create :user, username: 'user1' }
    let!(:user2) { FactoryGirl.create :user, username: 'user2' }

    describe '#respond' do
      it 'returns all the users' do
        response = handler.response

        expect(response.count).to eq 2
        expect(response[1]['username']).to eq 'user2'
      end
    end
  end
end
