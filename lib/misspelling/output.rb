require 'rainbow/ext/string'

module Misspelling
  class Output
    attr_reader :data

    def initialize(file_name:)
      @file_name = file_name
      @data = []
    end

    def add(line_number:, input:, suggestion:, context: nil)
      @data << { line_number: line_number,
                 input: input,
                 suggestion: suggestion,
                 context: context }
    end

    def show
      return if @data.empty?
      puts 'There are misspellings on ' <<
           Rainbow(@file_name).underline.yellow <<
           "\n\n"

      @data.each do |value|
        suggest = ''
        print 'Line: ' + Rainbow(value[:line_number].to_s.ljust(6)).bright.red
        print " Word: " + Rainbow(value[:input].ljust(20)).red
        print " Suggestions: "

        value[:suggestion].each_with_index do |word, index|
          suggest << ' or ' if index > 0
          suggest << Rainbow(word).green
        end
        print suggest.ljust(40)
        print "\n"
      end

      puts '=' * 100
    end
  end
end
