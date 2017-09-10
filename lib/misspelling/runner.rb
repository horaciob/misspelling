require 'yaml'

module Misspelling
  class Runner
    class RunnerError < StandardError; end

    def initialize(options: {})
      @config = Misspelling::Config.new(options: options)
      @outputs = []
    end

    def start
      @config.file_list.each do |file|
        checker = FileChecker.new(file_name: file)
        checker.process

        @outputs << checker.output
      end
    end

    def show_result
      @outputs.each(&:show)
    end
  end
end
