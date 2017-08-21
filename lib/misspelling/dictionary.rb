require_relative '../../config/dictionary'
require 'singleton'

module Misspelling
  # Mannage dictionary, check for typos on a word and gives
  # suggestions
  class Dictionary
    include Singleton

    attr_reader :dict
    def initialize
      @dict = load_dict
    end

    def check_typo(word)
      return false unless word =~ /^([a-zA-Z][a-zA-Z0-9]*)/
      normalized_word = word.downcase
      value = @dict[normalized_word[0]][normalized_word]
      if value
        value = value.map(&:capitalize) if capitalized?(word)
        value
      else
        false
      end
    end

    private

    def capitalized?(word)
      !!(word[0] =~ /[A-Z]/)
    end
  end
end
