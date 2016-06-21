require 'spec_helper'
require 'project-name/websocket/handler/things/create'

describe ProjectName::Websocket::Handler::Things::Create do

  describe '#new' do
    let(:name) { 'New Thing' }
    let(:description) { 'New Thing description' }

    it 'creates a thing' do
      expect {
        ProjectName::Websocket::Handler::Things::Create.new(
          websocket: double("Websocket", send: nil),
          websocket_message_id: 1,
          name: name,
          description: description
        )
      }.to change {
        ProjectName::Model::Thing.count
      }.from(0).to(1)

      new_thing = ProjectName::Model::Thing.last
      expect(new_thing.name).to eq name
      expect(new_thing.description).to eq description
    end
  end
end
