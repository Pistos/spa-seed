require 'spec_helper'
require 'project-name/null-logger'
require 'project-name/websocket/message-handler'

describe ProjectName::Websocket::MessageHandler do
  describe '#handle' do
    let(:broadcaster) { double("Broadcaster", broadcast: nil) }
    let(:websocket) { double("Websocket", send: nil) }
    let(:payload) { {} }
    let(:json_payload) { payload.to_json }
    let(:handler) {
      ProjectName::Websocket::MessageHandler.new(
        broadcaster: broadcaster,
        websocket: websocket,
        json_payload: json_payload,
        logger: ProjectName::NullLogger.new
      ).tap { |h|
        allow(h).to receive(:message_handler).and_return(specific_handler)
      }
    }
    let(:specific_handler) { nil }

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
        expect(specific_handler).to receive(:respond)
        handler.handle
      end
    end

    describe '[messages requiring authentication]' do
      let(:payload) {
        {
          'id' => 1,
          'message' => '/things',
          'args' => {},
        }
      }
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
        let(:authenticated) { nil }

        before do
          expect(websocket).to receive(:'authenticated?').and_return(authenticated)
        end

        context 'when the correct credentials are supplied' do
          let(:authenticated) { true }

          it 'responds normally' do
            expect(specific_handler).to receive(:respond)
            handler.handle
          end
        end

        context 'when the wrong credentials are supplied' do
          let(:authenticated) { false }

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
end
