require 'optparse'
require 'ostruct'

module Misspelling
  class Options
    attr_reader :options
    def initialize
      @options = {}
    end

    def parse(args)
      parser = OptionParser.new
      define_options(parser)
      parser.parse!(args)
      @options
    end

    private

    def define_options(parser)
      parser.banner = 'Usage: example.rb [options]'
      parser.separator ''
      parser.separator 'Specific options:'

      include_files(parser)
      exclude_files(parser)
      config_file(parser)

      parser.on_tail('-h', '--help', 'Show this message') do
        puts parser
        exit
      end

      parser.on_tail('--version', 'Show version') do
        puts Misspelling::VERSION
        exit
      end
    end

    def exclude_files(parser)
      help = 'If specified, it excludes files matching the given filename ' \
				"pattern from the search.\nNote that --exclude patterns take " \
				'priority over --include patterns'
      parser.on('-e', '--exclude pattern1,pattern2,...patternN', Array, help) do |patterns|
        @options[:exclude_patterns] = patterns
      end
    end

    def include_files(parser)
      help = 'Included pattern will be added to paths'
      parser.on('-i', '--include pattern1,pattern2,..patternN', Array, help) do |patterns|
        @options[:include_patterns] = patterns
      end
    end

    def config_file(parser)
      help = 'Specify configuration file. By default will look for .misspelling.yml'
      parser.on('-c', '--config_file file', String, help) do |file_name|
        @options[:config_file] = file_name
      end
    end
  end
end
