# frozen_string_literal: false

# will handle all user-input for the game
class Input
  def self.guess(guessed)
    puts 'Enter a new letter:'
    letter = gets.chomp.downcase
    # make sure the letter hasn't been guessed, is only one letter, and is a letter (not a number)
    return letter unless guessed.include?(letter) || letter.length != 1 || letter.match?(/[^a-z]/)

    puts 'Not a valid letter. '
    guess(guessed)
  end
end
