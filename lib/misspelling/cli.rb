module Misspelling
  class Cli
    def initialize
      @options = {}
    end

    def run(args = ARGV)
      options = Misspelling::Options.new.parse(args)
      runner = Misspelling::Runner.new(options: options)
      runner.start
      runner.show_result
    end
  end
end
