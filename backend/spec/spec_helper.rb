if ENV['PROJECT_NAME_ENV'] != 'test' && ! ENV['PROJECT_NAME_ENV_FORCE']
  $stderr.puts 'PROJECT_NAME_ENV is not "test".  Set PROJECT_NAME_ENV_FORCE to run tests anyway.'
  exit 1
end

require 'project-name/config'
require 'project-name/model'

require 'database_cleaner'
require 'factory_girl'
require 'pry'

require 'factories'
require 'spec-helpers'

# So that FactoryGirl can be used with Sequel
class Sequel::Model
  alias_method :save!, :save
end

RSpec.configure do |config|
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
end

RSpec::Matchers.define :json_hash do |hash|
  match { |actual|
    JSON.parse(actual) == hash
  }
end
