require 'jwt'
require 'project-name/config'

module ProjectName
  module JWT
    def self.for(user:)
      ::JWT.encode(
        {'user_id' => user.id},
        $conf['jwt_secret']
      )
    end
  end
end
