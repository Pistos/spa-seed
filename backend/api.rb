require 'grape'
require 'json'
require 'jwt'

require 'rack/contrib'

require 'config'
require 'model'

class API < Grape::API
  use Rack::JSONP
  format :json
  prefix 'api'

  helpers do
    def current_user
      return @current_user  if @current_user

      begin
        jwt_payload = JWT.decode(
          params['jwt'].to_s,
          $conf['jwt_secret']
        )
        if jwt_payload
          @current_user = Model::User[id: jwt_payload[0]['user_id'].to_i]
        end
      rescue JWT::DecodeError
        nil
      end
    end

    def authenticate!
      if current_user.nil?
        error!('401 Unauthorized', 401)
      end
    end
  end

  resource 'users' do
    desc "Sign up as a new user"
    params do
      requires 'username', type: String
      requires 'password', type: String
    end
    post do
      Model::User.create_with_creds(
        username: params['username'],
        plaintext_password: params['password']
      )

      {'success' => true}
    end

    resource 'authentications' do
      desc "Sign in"
      params do
        requires 'username', type: String
        requires 'password', type: String
      end
      post do
        user = Model::User.find_by_creds(
          username: params['username'],
          plaintext_password: params['password']
        )
        if user
          payload = { 'user_id' => user.id }
          { 'jwt' => JWT.encode(payload, $conf['jwt_secret']) }
        else
          error!('404 No user found', 404)
        end
      end
    end
  end

  resource 'things' do
    before do
      authenticate!
    end

    desc "Return things"
    get do
      Model::Thing.all.map(&:to_serializable)
    end

    desc "Create a thing"
    params do
      requires 'name', type: String
      requires 'description', type: String
    end
    post do
      Model::Thing.create(
        name: params['name'],
        description: params['description']
      ).to_serializable
    end
  end
end
