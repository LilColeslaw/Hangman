# frozen_string_literal: false

require './input'
require './output'
require './saving'

# will handle the inner workings of the game
class Play
  attr_reader :word, :guesses, :guessed
  include Input
  include Output
  include Saving

  # use optional arguments to assign variables -> if loading new game will have all variables
  def initialize(word = nil, guesses = 6, guessed = [])
    @word = word
    @word ||= pick_word
    @guesses = guesses
    @guessed = guessed
    @won = false
    if !word && load_game? # if self is not a loaded game, and the user wants to load a game then do so
      if Dir.glob('./games/*').length.zero?
        puts 'No saved games -- starting a new one...'
        sleep(1.5)
        start_message(@word, @guesses, @guessed)
        play
      else
        load
      end
    else # otherwise start play, and introduce the game
      start_message(@word, @guesses, @guessed)
      play
    end
  end

  def pick_word
    File.open('./words.txt').readlines.map(&:chomp).filter { |word| word.length.between?(5, 12) }.sample
  end

  def play
    while @guesses.positive? && !@won
      guess = guess(@guessed, self)
      @guessed << guess
      # lower their guesses left only if they guess a letter which is not in the word
      @guesses -= 1 unless @word.split('').include? guess
      @won = response(@word, @guessed, @guesses)
    end
    @won ? won : lost(@word)
    to_new_game?
  end
end
