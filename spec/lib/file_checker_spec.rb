require 'spec_helper'

require 'byebug'
RSpec.describe Misspelling::FileChecker do
  subject(:file_checker) do
    described_class.new(file_name: 'fake_file')
  end

  describe '#process' do
    context 'on success' do
      it 'open given file' do
        expect(File).to receive(:readlines)
          .with('fake_file')
          .and_return([])

        file_checker.process
      end

      it 'returns errors three errors' do
        allow(File)
          .to receive(:readlines)
          .and_return(['abandonned aberation', 'zeebra', 'one twoo'])
        report = file_checker.process
        expect(report.data.size).to eq 3
      end
    end

    describe '#process_line' do
      context 'on errors' do
        it 'returns 2 errors' do
          expect(file_checker.process_line(line: 'abandonned zeebra'))
            .to eq [{ input: 'abandonned',
                      suggestion: ['abandoned'],
                      context: 'abandonned zeebra' },
                    { input: 'zeebra',
                      suggestion: ['zebra'],
                      context: 'abandonned zeebra' } ]
        end
      end
    end
  end
end
