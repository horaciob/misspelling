require 'spec_helper'

RSpec.describe Misspelling::Dictionary do
  subject(:dict) { described_class.instance }

  describe '#initialize' do
    it 'loads a dictionary' do
      expect(dict.dict.keys)
        .to match_array %w[a b c d e f g
                           h i j k l m n
                           o p q r s t u
                           v w y x z]
    end
  end

  describe 'check_typo' do
    context 'when no typo' do
      it 'returns false' do
        expect(dict.check_typo('yourself')).to be false
      end
    end

    context 'when a non word is given' do
      it 'returns false if starts with special char' do
        expect(dict.check_typo('_anual')).to be false
      end

      it 'returns false if starts with number' do
        expect(dict.check_typo('1yaer')).to be false
      end
    end

    context 'when is a typo' do
      context 'on single suggestion' do
        it 'returns an array' do
          expect(dict.check_typo('archetectural')).to eq ['architectural']
        end
      end

      context 'on a several suggestions' do
        it 'returns an array' do
          expect(dict.check_typo('behavour')).to eq %w[behavior behaviour]
        end

        it 'returns capitalized suggestions for capitalized args' do
          expect(dict.check_typo('Behavour')).to eq %w[Behavior Behaviour]
        end
      end
    end
  end

  describe '#capitalized?' do
    it 'returns true if word is capitalized' do
      expect(dict.send(:capitalized?, 'Some')).to eq true
    end
    it 'returns false if word is not capitalized' do
      expect(dict.send(:capitalized?, 'some')).to eq false
    end
  end
end
