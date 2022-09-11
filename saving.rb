# frozen_string_literal: false

require 'json'
require './input'
require './play'

# will save and load game files
module Saving
  def self.save(game)
    Dir.mkdir('games') unless File.exist?('games')
    game_name = Input.call_game
    game_name = Input.call_game while Dir.glob('./games/*').include?(game_name)
    game_json = JSON.dump({word: game.word, guesses: game.guesses, guessed: game.guessed})
    File.open("./games/#{game_name}.txt", 'w') { |file| file.write(game_json) }
  end

  def self.load
    games = Dir.glob('./games/*').map { |file| file.sub('./games/', '').chomp('.txt') }
    puts 'Games saved:'
    games.each_with_index { |file, index| puts "#{index + 1}: #{file}" }
    game = Input.select_game(games)
    game = JSON.parse(File.read("./games/#{game}.txt"), symbolize_names: true)
    Play.new(game[:word], game[:guesses], game[:guessed])
  end
end
