require 'spec_helper'

RSpec.describe Misspelling::Config do
  subject(:config) { described_class.new }

  describe '#load_file' do
    context 'given a config file' do
      before do
        allow(File).to receive(:exist?)
          .and_return(true)
      end

      it 'loads a file' do
        expect(YAML).to receive(:load_file)
          .with('/my/fake/file.yml')
          .and_return('')

        config.load_file(file_name: '/my/fake/file.yml')
      end
    end

    context 'when no special file are give' do
      before do
        allow(File).to receive(:exist?)
          .and_return(true)
      end

      it 'looks for .misspeling.yml file' do
        expect(YAML).to receive(:load_file)
          .with('.misspelling.yml')
          .and_return('')

        config.load_file
      end
    end
  end
end
