require 'project-name/config'
require 'project-name/model'

require 'pry'
require 'factory_girl'
require 'factories'
require 'database_cleaner'

# So that FactoryGirl can be used with Sequel
class Sequel::Model
  alias_method :save!, :save
end

RSpec.configure do |config|
  config.before(:suite) do
    DatabaseCleaner.start
    DatabaseCleaner.clean
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end
end
