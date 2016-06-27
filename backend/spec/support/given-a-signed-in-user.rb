require 'project-name/jwt'

shared_context 'given a signed-in user' do
  include_context 'given a user'

  before do
    visit 'http://localhost:3010/'
    jwt = ProjectName::JWT.for(user: user)
    page.execute_script "localStorage.setItem('jwt', '#{jwt}')"
    visit 'http://localhost:3010/!#/home'
  end
end
