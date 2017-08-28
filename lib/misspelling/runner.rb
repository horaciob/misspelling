require 'yaml'

module Misspelling
  class Runner
    class RunnerError < StandardError; end

    def initialize(_argv)
      @config = Misspelling::Config.new(options:{})
      @outputs = []
    end

    def start
      file_list.each do |file|
        checker = FileChecker.new(file_name: file)
        checker.process

        @outputs << checker.output
      end
    end

    def file_list
      files = []
      @config.file_filters.map do |filter|
        Dir.glob(filter).each do |file|
          files << file
        end
      end

      files
    end

    def show_result
      @outputs.each(&:show)
    end
  end
end
