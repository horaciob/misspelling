module Misspelling
  class Cli
    def initialize
      @options = {}
      @config_store = ConfigStore.new
    end

    def run(args = ARGV)
      @options, paths = Options.new.parse(args)
    end
  end
end
