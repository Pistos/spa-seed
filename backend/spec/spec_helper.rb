if ENV['PROJECT_NAME_ENV'] != 'test' && ! ENV['PROJECT_NAME_ENV_FORCE']
  $stderr.puts 'PROJECT_NAME_ENV is not "test".  Set PROJECT_NAME_ENV_FORCE to run tests anyway.'
  exit 1
end

# TODO: We should probably start up a separate frontend and backend for the
# e2e tests.  There's risk someone will run tests against their development or
# production DB!

require 'project-name/config'
require 'project-name/model'

require 'capybara/rspec'
require 'database_cleaner'
require 'factory_girl'
require 'pry'

require 'factories'
require 'spec-helpers'

Dir['./spec/support/**/*.rb'].sort.each do |f|
  require f
end

TEST_SERVER = 'http://localhost:3011/'

# So that FactoryGirl can be used with Sequel
class Sequel::Model
  alias_method :save!, :save
end

RSpec.configure do |config|
  config.pattern = '**{,/*/**}/*-spec.rb'

  config.include SpecHelpers

  config.before(:suite) do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.start
    DatabaseCleaner.clean
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end

  config.before(:each, js: true) do
    visit TEST_SERVER
    page.execute_script %{localStorage.clear()}
  end
end

RSpec::Matchers.define :json_hash do |hash|
  match { |actual|
    JSON.parse(actual) == hash
  }
end

if ENV['TEST_WITH_BROWSER']
  Capybara.default_driver = :selenium
else
  require 'capybara/poltergeist'
  Capybara.javascript_driver = :poltergeist
end
