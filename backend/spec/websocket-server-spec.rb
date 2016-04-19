require 'spec_helper'
require 'project-name/websocket-server'

describe ProjectName::WebsocketServer do
  let(:websockets) { [] }
  let(:server) {
    ProjectName::WebsocketServer.new.tap { |s|
      websockets.each do |ws|
        s.auth_websockets << ws
      end
    }
  }

  context 'given some websockets authenticated by users' do
    let(:ws1) { authenticated_websocket }
    let(:ws2) { authenticated_websocket }
    let(:websockets) { [ ws1, ws2, ] }

    context 'given a payload' do
      let(:payload) { 'the payload' }

      describe '#broadcast' do
        it 'sends the payload to all websockets' do
          expect(ws1).to receive(:send).with payload
          expect(ws2).to receive(:send).with payload

          server.broadcast payload
        end
      end

      describe '#broadcast_to_user' do
        it 'sends the payload only to the websockets of the given user' do
          expect(ws1).not_to receive(:send).with payload
          expect(ws2).to receive(:send).with payload

          server.broadcast_to_user(user: ws2.user, payload: payload)
        end
      end
    end
  end
end
