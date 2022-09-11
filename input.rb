# frozen_string_literal: false

# will handle all user-input for the game
module Input
  def self.guess(guessed)
    puts 'Enter a letter:'
    letter = gets.chomp.downcase
    # make sure the letter hasn't been guessed, is only one letter, and is a letter (not a number)
    return letter unless guessed.include?(letter) || letter.length != 1 || letter.match?(/[^a-z]/)

    puts 'Not a valid letter. Type in a single letter that you have not guessed before.'
    guess(guessed)
  end

  def self.call_game
    puts 'Enter what you would like to call the game:'
    gets.chomp.gsub(' ', '_')
  end

  def self.select_game(games)
    puts 'Enter the number or name of the game you want to load:'
    game = gets.chomp
    # make sure it's valid
    until games.include?(game) || game.to_i <= games.length
      puts 'Not a valid game. Retry.'
      game = gets.chomp
    end
    games.include?(game) ? game : games[game - 1] # return the name even if they gave a number
  end

  def self.load_game?
    puts 'Would you like to play a new game or load a previous one? Enter "new" or "load" to choose:'
    choice = gets.chomp.downcase
    until %(load new).include? choice
      puts 'Not a valid choice. Enter "new" or "load":'
      choice = gets.chomp.downcase
    end
    choice == 'new' ? false : true
  end
end
