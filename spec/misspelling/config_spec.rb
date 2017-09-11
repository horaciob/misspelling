require 'spec_helper'

RSpec.describe Misspelling::Config do
  subject(:config) { described_class.new(options: {}) }


  describe '#included_files' do 
    it 'return a mix of default and given files' do 
      allow(config).to receive(:load_file).and_return({})
      list = config.send(:default_params)['Files']['Include'] + ['fake2.rb']
      config.instance_variable_set(:@options, { include_patterns:['fake2.rb']})

      expect(Dir).to receive(:glob).with(array_including(list)).and_return([]) 

      config.included_files
    end
  end

  describe '#excluded_files' do 
    it 'return a mix of default and given files' do 
      allow(config).to receive(:load_file).and_return({})
      config.instance_variable_set(:@options, { exclude_patterns:['fake2.rb']})

      expect(Dir).to receive(:glob).with(["**/*.log", "fake2.rb"]).and_return([]) 

      config.excluded_files
    end
  end

  describe '#file_list' do 
    it 'returns a list of included files without excluded' do 
      allow(config).to receive(:load_file).and_return({})
      allow(config).to receive(:included_files).and_return(%w{a b c d})
      allow(config).to receive(:excluded_files).and_return(%w{a c})

      expect(config.file_list).to contain_exactly('b', 'd')
    end
  end

  describe '#load_file' do
    context 'given a config file' do
      context 'when a different file is given' do
        subject(:config) do
          described_class.new(options: { config_file: '/my/fake/file.yml' })
        end

        it 'loads a file' do
          allow(File).to receive(:exist?)
            .with('/my/fake/file.yml')
            .and_return(true)

          expect(YAML).to receive(:load_file)
            .with('/my/fake/file.yml')
            .and_return({})

          config
        end

        it 'raise error if not exist' do
          allow(File).to receive(:exist?)
            .with('/my/fake/file.yml')
            .and_return(false)

          expect { config.send(:load_file)}
            .to raise_error Misspelling::Config::ConfigError
        end
      end
    end

    context 'when no special file are give' do

      it 'looks for .misspeling.yml file' do
        allow(File).to receive(:exist?)
          .with('.misspelling.yml')
          .and_return(true)

        expect(YAML).to receive(:load_file)
          .with('.misspelling.yml')
          .and_return({})

        config
      end

      it 'returns empty hash if .misspelling does not exists' do
        allow(File).to receive(:exist?)
          .with('.misspelling.yml')
          .and_return(false)
        expect(config).to be {}
      end
    end
  end
end
