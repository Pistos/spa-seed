module SpecHelpers
  def authenticated_websocket
    user = FactoryGirl.create(:user)

    ProjectName::Websocket::AuthenticatableWebsocket.new(
      websocket: double("Websocket")
    ).tap { |aws|
      jwt = JWT.encode(
        {'user_id' => user.id},
        $conf['jwt_secret']
      )

      json_payload = {
        'id' => 1,
        'message' => '/things',
        'jwt' => jwt,
      }.to_json

      aws.authenticate(json_payload)
    }
  end
end
