def pick_word
  File.open('./words.txt').readlines.map(&:chomp).filter { |word| word.length.between?(5, 12) }.sample
end
