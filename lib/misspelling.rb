require 'rainbow'
require 'misspelling/version'
require 'misspelling/dictionary'
require 'misspelling/output'
require 'misspelling/file_checker'

module Misspelling
  processor = FileChecker.new(file_name: '/tmp/pepe')
  processor.process
  processor.output.show
end
