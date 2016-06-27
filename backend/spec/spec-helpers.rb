module SpecHelpers
  def authenticated_websocket
    user = FactoryGirl.create(:user)

    ProjectName::Websocket::AuthenticatableWebsocket.new(
      websocket: double("Websocket")
    ).tap { |aws|
      jwt = ProjectName::JWT.for(user: user)

      json_payload = {
        'id' => 1,
        'message' => '/things',
        'jwt' => jwt,
      }.to_json

      aws.authenticate(json_payload)
    }
  end
end
