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
end
