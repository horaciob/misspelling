require 'yaml'

module Misspelling
  class Config
    class ConfigError < StandardError; end

    def initialize(options:)
      @options = options
      @file_name = options.fetch(:config_file, '.misspelling.yml')
      @params = base_params
    end

    def included_files
      patterns = @params['Files']['Include'] | @options.fetch(:include_patterns,
                                                              [])
      Dir.glob(patterns).map { |b| File.expand_path(b) }.uniq
    end

    def excluded_files
      patterns = @params['Files']['Exclude'] | @options.fetch(:exclude_patterns,
                                                              [])
      Dir.glob(patterns).map { |b| File.expand_path(b) }.uniq
    end

    def file_list
      included_files - excluded_files
    end

    private

    def base_params
      default_params.merge(load_file)
    end

    def default_params
      { 'Files' =>
        { 'Include' => ['**/*.rb',
                        '**/*.slim',
                        '**/*.haml',
                        '**/*.erb',
                        '**/*.yml',
                        '**/*.erb ',
                        '**/*.builder',
                        '**/*.sass',
                        '**/*.scss',
                        '**/*.less',
                        '**/*.liquid',
                        '**/*.markdown',
                        '**/*.mkd',
                        '**/*.md',
                        '**/*.textile',
                        '**/*.rdoc',
                        '**/*.asciidoc',
                        '**/*.ad',
                        '**/*.radius',
                        '**/*.slim',
                        '**/*.mw',
                        '**/*.coffee',
                        '**/*.styl',
                        '**/*.yajl',
                        '**/*.wlang'],
          'Exclude' => ['**/*.log'] },
        'Words' => { 'Include' => [{}],
                     'Exclude' => ['zeebra'] } }
    end

    def load_file
      if @file_name != '.misspelling.yml' && !File.exist?(@file_name)
        raise ConfigError, "Could not find #{@file_name}"
      end

      return {} unless File.exist?(@file_name)

      begin
        config = YAML.load_file(@file_name)
      rescue Psych::SyntaxError => error
        puts error.message
        raise ConfigError, error.message
      end
      config
    end
  end
end
