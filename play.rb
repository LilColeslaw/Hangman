# frozen_string_literal: false

require './saving'
require './input'
require './output'
Saving.load

# will handle the inner workings of the game
class Play
  attr_reader :word, :guesses, :guessed

  # use optional arguments to assign variables -> if loading new game will have all variables
  def initialize(word = nil, guesses = 6, guessed = [])
    @word = word
    @word ||= pick_word
    @guesses = guesses
    @guessed = guessed
    @finished = false
    if !word && Input.load_game? # if self is not a loaded game, and the user wants to load a game then do so
      Saving.load
    else # otherwise start play, and introduce the game
      Output.begin(@word, @guesses, @guessed)
      play
    end
  end

  def pick_word
    File.open('./words.txt').readlines.map(&:chomp).filter { |word| word.length.between?(5, 12) }.sample
  end

  def play
    while @guesses.positive? && !@finished
      guess = Input.guess(@guessed)
      @guessed << guess
      # lower their guesses left only if they guess a letter which is not in the word
      @guesses -= 1 unless @word.split('').include? guess
      @finished = Output.response(@word, @guessed, @guesses)
    end
  end
end
Play.new
