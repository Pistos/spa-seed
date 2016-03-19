require 'spec_helper'
require 'project-name/websocket/message-handler'

describe ProjectName::Websocket::MessageHandler do
  let(:websocket) { double("Websocket", send: nil) }
  let(:json_payload) { payload.to_json }
  let(:handler) {
    ProjectName::Websocket::MessageHandler.new(
      websocket: websocket,
      json_payload: json_payload
    )
  }
  let(:specific_handler) { nil }

  before do
    allow_any_instance_of(ProjectName::Websocket::MessageHandler).to receive(:message_handler).and_return(specific_handler)
  end

  describe '[messages NOT requiring authentication]' do
    let(:payload) {
      {
        'id' => 1,
        'message' => '/users/create',
        'args' => {},
      }
    }

    let(:specific_handler) { double('Handler::Users::Create') }

    it 'processes the message without authentication' do
      allow_any_instance_of(ProjectName::Websocket::MessageHandler).to receive(:message_handler).and_return(specific_handler)
      expect(specific_handler).to receive(:respond)
      handler.handle
    end
  end

  describe '[messages requiring authentication]' do
    let(:payload) {
      {
        'id' => 1,
        'message' => '/things',
        'args' => {'jwt' => jwt,},
      }
    }
    let(:jwt) { nil }

    let(:specific_handler) { double('Handler::Things::List') }

    context 'given a user' do
      let(:username) { 'joe' }
      let(:password) { 'abcd' }
      let(:user) {
        FactoryGirl.create(:user, username: username).tap { |u|
          u.password = password
          u.save
        }
      }

      context 'when the correct credentials are supplied' do
        let(:jwt) { JWT.encode({ 'user_id' => user.id }, $conf['jwt_secret']) }

        it 'responds normally' do
          expect(specific_handler).to receive(:respond)
          handler.handle
        end
      end

      context 'when the wrong credentials are supplied' do
        let(:jwt) { 'attempted JWT spoof' }

        it 'responds with an error' do
          expect(specific_handler).not_to receive(:respond)
          expect(websocket).to receive(:send).with(json_hash({
            'id' => 1,
            'response' => {'error' => 'Unauthorized'}
          }))
          handler.handle
        end
      end
    end
  end
end
