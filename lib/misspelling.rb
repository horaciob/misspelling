require 'rainbow'
require_relative 'misspelling/version'
require_relative 'misspelling/dictionary'
require_relative 'misspelling/output'
require_relative 'misspelling/file_processor'

module Misspelling
  dict = Misspelling::Dictionary.new
  processor = FileProcessor.new(file_name: '/tmp/pepe', dict: dict)
  processor.process
  processor.output.show
end
