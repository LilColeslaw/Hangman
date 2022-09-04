# frozen_string_literal: false

require './input'
require './output'

# will handle the inner workings of the game
class Play
  attr_reader :word

  def initialize
    @word = pick_word
    @guesses = 6
    @guessed = []
    @won = false
    Output.begin(@word)
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
    Output.lost(@word) unless @won
  end
end
Play.new
