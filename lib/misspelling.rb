require 'rainbow'
require 'misspelling/runner'
require 'misspelling/version'
require 'misspelling/config'
require 'misspelling/dictionary'
require 'misspelling/output'
require 'misspelling/file_checker'

module Misspelling
  runner = Misspelling::Runner.new(options:'la')
  runner.file_list
  runner.show_result
end
