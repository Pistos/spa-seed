require 'project-name/jwt'

shared_context 'given a signed-in user' do
  include_context 'given a user'

  before do
    visit TEST_SERVER
    jwt = ProjectName::JWT.for(user: user)
    page.execute_script "localStorage.setItem('jwt', '#{jwt}')"
    visit "#{TEST_SERVER}!#/home"
  end
end
