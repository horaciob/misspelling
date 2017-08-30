module Misspelling
  class Cli
    def initialize
      @options = {}
    end

    def run(args = ARGV)
      # TODO parser options
      # @options, paths = Options.new.parse(args)
      runner = Misspelling::Runner.new(options: @options)
      runner.start
      runner.show_result
    end
  end
end
