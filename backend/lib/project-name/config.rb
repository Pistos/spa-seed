require 'yaml'

module ProjectName
  class ConfigError < StandardError; end

  class Config
    def initialize
      @env = ENV['PROJECT_NAME_ENV'] || 'development'
      @default_configuration = read_conf_from_yaml_file('./defaults.yaml')
      @custom_configuration = read_conf_from_yaml_file('./config.yaml')
      @custom_configuration['env'] = @env
    end

    def [](key_path)
      traverse_configuration(
        configuration: @custom_configuration,
        key_path: key_path
      ) || traverse_configuration(
        configuration: @default_configuration,
        key_path: key_path
      )
    end

    private

    def read_conf_from_yaml_file(filepath)
      if File.exists?(filepath)
        raw_yaml = YAML.load(IO.read(filepath))
        raw_yaml && raw_yaml[@env] || {}
      else
        {}
      end
    end

    def traverse_configuration(configuration:, key_path:)
      keys = key_path.split('/')
      pointer = configuration
      while keys.any?
        if pointer.respond_to?(:'[]')
          pointer = pointer[keys.shift]
        else
          return nil
        end
      end
      pointer
    end
  end
end

$conf = ProjectName::Config.new

if $conf['jwt_secret'].nil? || $conf['jwt_secret'].empty?
  raise ProjectName::ConfigError.new('Must configure jwt_secret in config.yaml')
end
