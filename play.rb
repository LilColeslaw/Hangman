# frozen_string_literal: false

require './input'
require './output'

# will handle the inner workings of the game
class Play
  attr_reader :word

  # use optional arguments to assign variables -> if loading new game will have all variables
  def initialize(word = nil, guesses = 6, guessed = [])
    @word = word
    @word ||= pick_word
    @guesses = guesses
    @guessed = guessed
    @won = false
    Output.begin(@word, @guesses, @guessed)
    play
  end

  def pick_word
    File.open('./words.txt').readlines.map(&:chomp).filter { |word| word.length.between?(5, 12) }.sample
  end

  def play
    while @guesses.positive? && !@won
      guess = Input.guess(@guessed)
      @guessed << guess
      # lower their guesses left only if they guess a letter which is not in the word
      @guesses -= 1 unless @word.split('').include? guess
      @won = Output.response(@word, @guessed, @guesses)
    end
  end
end
Play.new('hello', 1, %w[h a e])
