require 'spec_helper'
require 'project-name/websocket/handler/users/own-id'

describe ProjectName::Websocket::Handler::Users::OwnId do
  context 'given a user' do
    let(:user) { FactoryGirl.create(:user) }
    subject(:handler) {
      ProjectName::Websocket::Handler::Users::OwnId.new(
        websocket: double(
          "Websocket",
          send: nil,
          user: user
        ),
        websocket_message_id: 1
      )
    }

    describe '#respond' do
      it 'returns the user of the authenticated websocket' do
        response = handler.response

        expect(response).to eq( { 'user_id' => user.id, } )
      end
    end
  end
end
