
class Computer < Game
  attr_reader :secret_word, :clue_string, :letter_store, :guess_string

  def initialize
    @secret_word = select_word
    @clue_string = make_clue
    @letter_store = []
  end

  def select_word
    dictionary = File.open('dictionary.txt')
    dictionary_array = []
    dictionary.each do |word|
      if word.length >= 5 && word.length <= 12
        dictionary_array.push(word)
      end
    end
    dictionary_array.sample
  end

  def make_clue
    clue_string = []
    @secret_word.each_char { clue_string.push('_') }
    puts clue_string = clue_string.join(' ')
  end

  def check_letter(letter)
    @letter_store.push(letter)
    if @secret_word.include?(letter)
      @guess_string = @secret_word.tr("^#{@letter_store.join('')}", '_')
      @clue_string = @guess_string.split(//).join(' ')
    end
    puts @clue_string
  end

end

# after selecting a word
# create a blank set of _ _ to show the player that's the same length as the word
# allow the player to enter a letter and search the word for the letter
	# if the letter is present replace the blank _ with the letter
# display incorrect guesses in an ordered list
# display a number of turns and count down to zero
# if the number of turns is 0 player loses