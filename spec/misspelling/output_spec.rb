require 'spec_helper'

RSpec.describe Misspelling::Output do
  subject(:output) { described_class.new(file_name: '/tmp/pepe') }

  describe '#initialize' do
    it 'creates a new output object' do
      expect(described_class.new(file_name: '/tmp/file'))
        .to be_a described_class
    end
  end

  describe '#add' do
    it 'add a new line to the output' do
      output.add(line_number: '12',
                 input: 'fake_input',
                 suggestion: %w[input input2])

      expect(output.data.count).to be 1
    end
  end
end
