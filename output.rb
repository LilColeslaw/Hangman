# frozen_string_literal: false

# will format all of the output
class Output
  def self.response(word, guessed)
    word = word.split('').map do |letter|
      if guessed.include? letter
        letter
      else
        '_'
      end
    end.join('')
    puts word
    puts "You have guessed: #{guessed.join(', ').chomp(', ')}"
  end
end
