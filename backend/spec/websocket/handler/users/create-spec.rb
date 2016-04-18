require 'spec_helper'
require 'project-name/websocket/handler/users/create'

describe ProjectName::Websocket::Handler::Users::Create do
  subject(:handler) {
    ProjectName::Websocket::Handler::Users::Create.new(
      websocket: double("Websocket", send: nil),
      id: 1,
      username: 'newusername',
      password: 'somepassword'
    )
  }

  describe '#respond' do
    it 'creates a new user' do
      expect {
        handler.respond
      }.to change {
        ProjectName::Model::User.count
      }.by(1)
    end
  end
end
