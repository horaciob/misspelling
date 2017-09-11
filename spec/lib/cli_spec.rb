require 'spec_helper'

RSpec.describe Misspelling::Cli do
  subject(:cli) do
    described_class.new
  end

  describe '#run' do 
    before do 
      @runner = instance_double(Misspelling::Runner)
      allow(Misspelling::Runner).to receive(:new).and_return(@runner)
    end
    it 'calls runner to start' do
      expect(@runner).to receive(:start)
      allow(@runner).to receive(:show_result)
      cli.run
    end

    it 'show results' do 
      allow(@runner).to receive(:start)
      expect(@runner).to receive(:show_result)
      cli.run
    end
  end
end

