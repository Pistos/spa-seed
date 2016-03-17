require 'spec_helper'
require 'project-name/websocket/handler/things/create'

describe ProjectName::Websocket::Handler::Things::Create do
  subject(:handler) {
    ProjectName::Websocket::Handler::Things::Create.new(
      name: 'New Thing',
      description: 'New Thing description'
    )
  }

  describe '#respond' do
    it 'creates a thing' do
      expect {
        handler.respond
      }.to change {
        ProjectName::Model::Thing.count
      }.by(1)
    end
  end
end
