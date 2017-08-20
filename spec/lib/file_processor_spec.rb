require 'spec_helper'

require 'byebug'
RSpec.describe Misspelling::FileProcessor do
  subject(:file_processor) do
    described_class.new(file_name: 'fake_file',
                        dict: Misspelling::Dictionary.new)
  end

  describe '#process' do
    context 'on success' do
      it 'open given file' do
        expect(File).to receive(:readlines)
          .with('fake_file')
          .and_return([])

        file_processor.process
      end

      it 'returns errors three errors' do
        allow(File)
          .to receive(:readlines)
          .and_return(['abandonned aberation', 'zeebra', 'one twoo'])
        report = file_processor.process
        expect(report.data.size).to eq 3
      end
    end

    describe '#process_line' do
      context 'on errors' do
        it 'returns 2 errors' do
          expect(file_processor.process_line(line: 'abandonned zeebra'))
            .to eq [{ input: 'abandonned', suggestion: ['abandoned'] },
                    { input: 'zeebra', suggestion: ['zebra'] }]
        end
      end
    end
  end
end
