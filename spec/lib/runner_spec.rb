require 'spec_helper'

RSpec.describe Misspelling::Runner do
  subject(:runner) { described_class.new }

  describe '#start' do
    before do
      @config = instance_double Misspelling::Config
      allow(Misspelling::Config).to receive(:new)
        .and_return @config
    end

    it 'call FileChecker for every included files' do
      checker = double
      allow(@config).to receive(:file_list)
        .and_return %w(fake_file1 fake_file2)

      allow(checker).to receive(:process)
      allow(checker).to receive(:output).and_return('something')

      expect(Misspelling::FileChecker).to receive(:new)
        .and_return(checker).twice

      runner.start
    end

    it 'calls FileChecker process' do
      checker = double
      allow(@config).to receive(:file_list)
        .and_return %w(fake_file1 fake_file2)

      allow(checker).to receive(:output).and_return('something')
      allow(Misspelling::FileChecker).to receive(:new)
        .and_return(checker)

      expect(checker).to receive(:process).twice

      runner.start
    end

    it 'call FileChecker output' do
      checker = double
      allow(@config).to receive(:file_list)
        .and_return %w(fake_file1 fake_file2)

      allow(checker).to receive(:process)
      allow(Misspelling::FileChecker).to receive(:new)
        .and_return(checker).twice

      expect(checker).to receive(:output).and_return('something').twice

      runner.start
    end
  end
  
  describe '#show_result' do 
    it 'calls show for every output' do 
      one = instance_double(Misspelling::Output)
      two = instance_double(Misspelling::Output)
      runner.instance_variable_set(:@outputs, [one,two])

      expect(one).to receive(:show) 
      expect(two).to receive(:show) 

      runner.show_result
    end
  end
end
