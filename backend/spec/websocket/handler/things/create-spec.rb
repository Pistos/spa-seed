require 'spec_helper'
require 'project-name/websocket/handler/things/create'

describe ProjectName::Websocket::Handler::Things::Create do
  subject(:handler) {
    ProjectName::Websocket::Handler::Things::Create.new(
      broadcaster: double("Broadcaster", broadcast: nil),
      name: 'New Thing',
      description: 'New Thing description'
    )
  }

  describe '#message' do
    it 'is nil' do
      expect(handler.message).to be_nil
    end
  end

  describe '#respond' do
    it 'creates a thing' do
      expect {
        handler.response
      }.to change {
        ProjectName::Model::Thing.count
      }.by(1)
    end
  end
end
