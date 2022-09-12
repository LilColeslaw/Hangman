# frozen_string_literal: false

require 'json'

# will save and load game files
module Saving
  def save(game)
    Dir.mkdir('games') unless File.exist?('games')
    game_name = call_game
    game_name = call_game while Dir.glob('./games/*').include?(game_name)
    game_json = JSON.dump({word: game.word, guesses: game.guesses, guessed: game.guessed})
    File.open("./games/#{game_name}.txt", 'w') { |file| file.write(game_json) }
    to_new_game?
  end

  def load
    puts 'Games saved:'
    games = find_games
    game_file = select_game(games)
    game = JSON.parse(File.read("./games/#{game_file}.txt"), symbolize_names: true)
    File.delete("./games/#{game_file}.txt")
    Play.new(game[:word], game[:guesses], game[:guessed])
  end

  def find_games
    games = Dir.glob('./games/*').map { |file| file.sub('./games/', '').chomp('.txt') }
    games.each_with_index { |game, index| puts "#{index + 1}: #{game}" }
    games
  end
end
