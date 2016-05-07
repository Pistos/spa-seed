module ProjectName
  class ConfigError < StandardError; end
  class Config; end
end

describe ProjectName::Config do
  let(:conf) { ProjectName::Config.new }
  let(:defaults_yaml) { '' }
  let(:config_yaml) { '' }

  before do
    allow(IO).to receive(:read).with('./defaults.yaml').and_return(defaults_yaml)
    allow(IO).to receive(:read).with('./config.yaml').and_return(config_yaml)
  end

  context 'with the config loaded' do
    before do
      require 'project-name/config'
    end

    context 'given a root value' do
      let(:defaults_yaml) { %{
        test:
          root_key: root-value
      } }

      it 'provides the root value' do
        expect(conf['root_key']).to eq 'root-value'
      end
    end

    context 'given an outer hash, but a missing inner value' do
      let(:defaults_yaml) { %{
        test:
          outer:
            other_inner: val
      } }

      it 'returns nil for the missing inner value' do
        expect(conf['outer/mising_inner']).to be_nil
      end
    end

    context 'given a missing subtree' do
      let(:defaults_yaml) { %{
        test:
          outer:
            inner: val
      } }

      it 'returns nil' do
        expect(conf['outer/mising_inner/missing_inner_inner']).to be_nil
        expect(conf['missing_outer/mising_inner/missing_inner_inner']).to be_nil
      end
    end

    context 'given a nested default value' do
      let(:defaults_yaml) { %{
        test:
          jwt_secret: boo
          outer:
            inner: inner-value
      } }

      context 'and no custom value specified' do
        it 'returns the default value' do
          expect(conf['outer/inner']).to eq 'inner-value'
        end
      end

      context 'and a custom value for that key path' do
        let(:config_yaml) { %{
          test:
            jwt_secret: boo
            outer:
              inner: custom-inner-value
        } }

        it 'returns the custom value' do
          expect(conf['outer/inner']).to eq 'custom-inner-value'
        end
      end
    end
  end
end
