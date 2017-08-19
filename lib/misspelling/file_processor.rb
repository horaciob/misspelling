module Misspelling
  class FileProcessor
    attr_reader :output

    def initialize(file_name:, dict:)
      @file_name = file_name
      @dict = dict
      @output = Misspelling::Output.new(file_name: file_name)
    end

    def process
      line_counter = 1
      begin
        File.readlines(@file_name).each do |line|
          errors = process_line(line: line)
          errors.each do |error|
            @output.add(line_number: line_counter,
                        input: error[:input],
                        suggestion: error[:suggestion])
          end

          line_counter += 1
        end
      rescue Errno::EACCES
        Rainbow("Could no access to #{@file_name} plese check permissions").red
      end

      @output
    end

    def process_line(line:)
      output = []
      words = line.scan(/[a-zA-Z][a-zA-Z0-9]+/)
      words.each do |word|
        suggestion = @dict.check_typo(word)
        output << { input: word, suggestion: suggestion } if suggestion
      end

      output
    end
  end
end
