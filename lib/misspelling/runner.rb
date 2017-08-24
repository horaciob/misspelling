require 'yaml'
module Misspelling
  class Runner
    class RunnerError < StandardError; end

    def initialize(_argv)
      @config = Misspelling::Config.new(options:{})
      @outputs = []
    end

    def file_list
      @config.file_filters.map do |filter|
        Dir.glob(filter).each do |file|
          @outputs << FileChecker.new(file_name: file).output
        end
      end
    end

    def show_result
      @outputs.each(&:show)
    end
  end
end
