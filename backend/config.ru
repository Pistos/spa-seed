require 'rack/cors'

use Rack::Cors do
  allow do
    # origins 'localhost:8080', '127.0.0.1:8080',
            # /\Ahttp:\/\/192\.168\.0\.\d{1,3}:8080\z/

    # This is insecure.  Change it before putting in production.
    origins '*'
    resource '*', headers: :any, methods: [:get, :post, :put, :delete, :options,]
  end
end

require './api.rb'

run API
