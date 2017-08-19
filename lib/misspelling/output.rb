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
      puts "There is some misspelling on " + Rainbow(@file_name).yellow
      @data.each do |value|
        puts 'Line: ' + Rainbow(value[:line_number]).red
        puts 'Word: ' + Rainbow(value[:input]).red
        puts 'Did you want to say? ' + Rainbow(value[:suggestion].join(' or ')).green
      end
    end
  end
end
