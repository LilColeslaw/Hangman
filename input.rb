# frozen_string_literal: false

# will handle all user-input for the game
class Input
  def self.ask_name
    puts 'Enter your name please:'
    name = gets.chomp
    return name unless name.length.zero?

    puts 'Please type in something'
    ask_name
  end

  def self.guess(guessed)
    puts 'Enter a new letter:'
    letter = gets.chomp.downcase
    # make sure the letter hasn't been guessed, is only one letter, and is a letter (not a number)
    return letter unless guessed.include?(letter) || letter.length != 1 || letter.match?(/[^a-z]/)

    puts 'Not a valid letter. '
    guess(guessed)
  end
end
