# frozen_string_literal: false

# will format all of the output
class Output
  def self.begin(word, guesses, guessed)
    puts "You must guess a word letter by letter. The word is #{word.length} letters long.\n"\
         "You have #{guesses} lives. Every time you guess a letter not included in the word you lose a life.\n"\
         'Try to guess the word before you lose all of your lives.'
    # if they are re-starting an old game, tell them what they have already guessed
    puts "You have guessed: #{guessed.join(', ').chomp(', ')}" unless guessed.empty?
  end

  def self.response(word, guessed, guesses)
    filled_in = word.split('').map do |letter|
      if guessed.include? letter
        letter
      else
        '_'
      end
    end.join('')
    puts filled_in
    if filled_in == word
      puts 'You won the game!'
      return true
    end
    if guesses.zero?
      lost(word)
      return false
    end
    puts "You have guessed: #{guessed.join(', ').chomp(', ')}"
    puts "You have #{guesses} lives left"
    false
  end

  def self.lost(word)
    puts "Too bad. The word was #{word}."
  end
end
