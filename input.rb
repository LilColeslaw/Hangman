# frozen_string_literal: false

# will handle all user-input for the game
class Input
  def self.guess(guessed)
    puts 'Enter a letter:'
    letter = gets.chomp.downcase
    # make sure the letter hasn't been guessed, is only one letter, and is a letter (not a number)
    return letter unless guessed.include?(letter) || letter.length != 1 || letter.match?(/[^a-z]/)

    puts 'Not a valid letter. Type in a single letter that you have not guessed before.'
    guess(guessed)
  end
end
