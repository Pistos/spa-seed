require 'spec_helper'
require 'project-name/websocket/authenticatable-websocket'

describe ProjectName::Websocket::AuthenticatableWebsocket do
  describe 'AuthenticatableWebsocket()' do
    let(:websocket) { nil }
    let(:value) { ProjectName::Websocket::AuthenticatableWebsocket(websocket) }

    context 'when something can authenticate' do
      let(:websocket) {
        double('AuthenticatableWebsocket').tap { |aws|
          allow(aws).to receive(:authenticate)
        }
      }

      it 'returns the thing as-is' do
        expect(value).to eq websocket
      end
    end

    context 'when something can NOT authenticate' do
      let(:websocket) { double('ThingThatCannotAuthenticate') }

      it 'returns something that can authenticate' do
        expect(websocket).not_to respond_to(:authenticate)
        expect {
          value.authenticate('{}')
        }.not_to raise_error
      end
    end
  end

  describe '#authenticate' do
    let(:aws) { ProjectName::Websocket::AuthenticatableWebsocket.new(websocket: double('Websocket')) }
    let(:payload) {
      {
        'id' => 1,
        'message' => '/things',
        'jwt' => jwt,
      }
    }
    let(:jwt) { nil }
    let(:json_payload) { payload.to_json }

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
        let(:jwt) {
          JWT.encode(
            {'user_id' => user.id},
            $conf['jwt_secret']
          )
        }

        it 'sets the user' do
          expect {
            aws.authenticate(json_payload)
          }.to change { aws.user }.from(ProjectName::Model::NilUser).to(user)
        end
      end

      context 'when the wrong credentials are supplied' do
        let(:jwt) { 'attempted JWT spoof' }

        it 'does not set the user' do
          expect {
            aws.authenticate(json_payload)
          }.not_to change { aws.user }.from(ProjectName::Model::NilUser)
        end
      end
    end
  end
end
