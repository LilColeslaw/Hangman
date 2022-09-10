# frozen_string_literal: false

require 'json'
require './input'
require './play'

# will save and load game files
class Saving
  def self.save(game)
    Dir.mkdir('games') unless File.exist?('games')
    game_name = Input.ask_name
    game_name = Input.ask_name while Dir.glob('./games/*').include?(game_name)
    game_json = JSON.dump({word: game.word, guesses: game.guesses, guessed: game.guessed})
    File.open("./games/#{game_name}.txt", 'w') { |file| file.write(game_json) }
  end
end
