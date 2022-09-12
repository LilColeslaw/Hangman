# frozen_string_literal: false

# will handle all user-input for the game
module Input
  # need 'game' parameter in case the player wants to save the game
  def guess(guessed, game)
    puts 'Enter a letter:'
    letter = gets.chomp.downcase
    # is the player saving a game?
    save(game) if letter == 'save'
    # make sure the letter hasn't been guessed, is only one letter, and is a letter (not a number)
    return letter unless guessed.include?(letter) || letter.length != 1 || letter.match?(/[^a-z]/)

    puts 'Not a valid letter. Type in a single letter that you have not guessed before.'
    guess(guessed, game)
  end

  def call_game
    puts 'Enter what you would like to call the game:'
    gets.chomp.gsub(' ', '_')
  end

  def select_game(games)
    puts 'Enter the number or name of the game you want to load:'
    game = gets.chomp
    # make sure it's valid
    until games.include?(game) || (game.to_i.positive? && game.to_i <= games.length)
      puts 'Not a valid game. Retry.'
      game = gets.chomp
    end
    games.include?(game) ? game : games[game.to_i - 1] # return the name even if they gave a number
  end

  def load_game?
    puts 'Would you like to play a new game or load a previous one? Enter "new" or "load" to choose:'
    choice = gets.chomp.downcase
    until %w[load new].include? choice
      puts 'Not a valid choice. Enter "new" or "load":'
      choice = gets.chomp.downcase
    end
    choice != 'new'
  end

  def to_new_game?
    puts "Continue playing by entering 'continue' -- End session by entering 'end'"
    choice = gets.chomp.strip
    until %w[continue end].include? choice
      puts "Not a valid option. Enter 'continue' or 'end':"
      choice = gets.chomp.strip
    end
    choice == 'continue' ? Play.new : goodbye
  end
end
