require 'jwt'

shared_context 'given a signed-in user' do
  include_context 'given a user'

  before do
    visit 'http://localhost:3010/'
    jwt = JWT.encode(
      {'user_id' => user.id},
      $conf['jwt_secret']
    )
    page.execute_script "localStorage.setItem('jwt', '#{jwt}')"
  end
end
