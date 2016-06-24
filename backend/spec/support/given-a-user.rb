shared_context 'given a user' do
  let(:username) { 'joe' }
  let(:password) { 'abcd' }
  let(:user) {
    FactoryGirl.create(:user, username: username).tap { |u|
      u.password = password
      u.save
    }
  }
end
