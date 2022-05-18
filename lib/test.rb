
def select_word
  dictionary = File.open("dictionary.txt")
  dictionary_array = Array.new
  dictionary.each do |word|
    if word.length >= 5 && word.length <= 12
      dictionary_array.push(word)
    end
  end
  dictionary_array.sample
end

secret_word = select_word

def clue(secret_word)
  clue = Array.new
  secret_word.each_char {|letter| clue.push("_")}
  clue = clue.join(' ')
end

clue_string = clue(secret_word)

def check_letter(letter, secret_word, clue_string)
  if secret_word.include?(letter)
    clue_string = secret_word.tr("^#{letter}", "_").split(//).join(' ')
  else clue_string
  end
  puts clue_string
end 

def guess(secret_word, clue_string)
  clue_string = clue_string
  puts "Enter a letter to guess the word"
  letter = gets.chomp
  check_letter(letter, secret_word, clue_string)
end

puts clue_string
puts secret_word
guess(secret_word, clue_string)
