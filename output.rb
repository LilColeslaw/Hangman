# frozen_string_literal: false

# will format all of the output
module Output
  def start_message(word, guesses, guessed)
    puts "You must guess a word letter by letter. The word is #{word.length} letters long.\n"\
         "You have #{guesses} lives. Every time you guess a letter not included in the word you lose a life.\n"\
         'Try to guess the word before you lose all of your lives. If you ever want to pause and save the game'\
         "\nyou are in to return to it later, just enter 'save' instead of a letter."
    # if they are re-starting an old game, tell them what they have already guessed
    return if guessed.empty?

    puts "You have guessed: #{guessed.join(', ').chomp(', ')}\nProgress: #{correct_letters(word, guessed)}"
  end

  def response(word, guessed, guesses)
    correct_letters = correct_letters(word, guessed)
    puts correct_letters
    return true if correct_letters == word

    puts "You have guessed: #{guessed.join(', ').chomp(', ')}"
    puts "You have #{guesses} lives left"
    false
  end

  def correct_letters(word, guessed)
    word.split('').map do |letter|
      if guessed.include? letter
        letter
      else
        '_'
      end
    end.join('')
  end

  def won
    puts 'You got the word, nice job!'
  end

  def lost(word)
    puts "Too bad. The word was #{word}."
  end

  def goodbye
    puts 'See you next time!'
  end
end
