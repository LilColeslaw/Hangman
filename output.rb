# frozen_string_literal: false

# will format all of the output
class Output
  def self.response(word, guessed)
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
    puts "You have guessed: #{guessed.join(', ').chomp(', ')}"
    puts "You have #{12 - guessed.length} guesses left"
    false
  end
end
