require 'yaml'

env = ENV['PROJECT_NAME_ENV'] || 'development'

default_configuration = YAML.load(IO.read('./defaults.yaml'))[env] || {}
custom_configuration = YAML.load(IO.read('./config.yaml'))[env] || {}

$conf = default_configuration.merge(custom_configuration)

module ProjectName
  class ConfigError < StandardError; end;
end

if $conf['jwt_secret'].nil? || $conf['jwt_secret'].empty?
  raise ProjectName::ConfigError.new('Must configure jwt_secret in config.yaml')
end
