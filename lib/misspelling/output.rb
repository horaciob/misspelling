require 'rainbow/ext/string'

module Misspelling
  class Output
    attr_reader :data

    def initialize(file_name:)
      @file_name = file_name
      @data = []
    end

    def add(line_number:, input:, suggestion:)
      @data << { line_number: line_number,
                 input: input,
                 suggestion: suggestion }
    end

    def show
      puts '=' * 100
      puts 'There is some misspelling on ' <<
           Rainbow(@file_name).underline.yellow <<
           "\n\n"

      @data.each do |value|
        print 'Line: ' + Rainbow(value[:line_number]).bright.red
        print " \t Word: " + Rainbow(value[:input]).red
        print " \t Suggestion "

        value[:suggestion].each_with_index do |word, index|
          print ' or ' if index > 0
          print Rainbow(word).green
        end
        puts ''
      end
      puts '=' * 100
    end
  end
end
