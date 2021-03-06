require 'spec_helper'
require 'project-name/websocket/handler/users/authentications/create'

describe ProjectName::Websocket::Handler::Users::Authentications::Create do
  subject(:handler) {
    ProjectName::Websocket::Handler::Users::Authentications::Create.new(
      websocket: double("Websocket", send: nil),
      websocket_message_id: 1,
      username: username_arg,
      password: password_arg
    )
  }

  context 'given a user' do
    include_context 'given a user'

    before do
      user
    end

    describe '#respond' do

      context 'when the username is wrong' do
        let(:username_arg) { 'someoneElse' }

        context 'when the password is right' do
          let(:password_arg) { password }

          it 'does NOT provide a user authentication token' do
            response = handler.response
            expect(response['jwt']).to be_nil
            expect(response['error']).to eq 'No user found'
          end
        end

        context 'when the password is wrong' do
          let(:password_arg) { 'wrongPassword' }

          it 'does NOT provide a user authentication token' do
            response = handler.response
            expect(response['jwt']).to be_nil
            expect(response['error']).to eq 'No user found'
          end
        end
      end

      context 'when the username is right' do
        let(:username_arg) { username }

        context 'when the password is right' do
          let(:password_arg) { password }

          it 'provides a user authentication token' do
            response = handler.response
            expect(response['jwt']).not_to be_nil
          end
        end

        context 'when the password is wrong' do
          let(:password_arg) { 'wrongPassword' }

          it 'does NOT provide a user authentication token' do
            response = handler.response
            expect(response['jwt']).to be_nil
            expect(response['error']).to eq 'No user found'
          end
        end
      end
    end
  end
end
