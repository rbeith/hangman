require './lib/Save_Game'

class Game
  include Save_Game

	def introduction
    puts 'Let\'s play a game of Hangman!'
	end
	
  def select_word
    dictionary = File.open('dictionary.txt')
    dictionary_array = []
    dictionary.each do |word|
      if word.length >= 5 && word.length <= 12
        dictionary_array.push(word)
      end
    end
    @secret_word = dictionary_array.sample.chomp
  end


  def check_letter(letter)
    @letter_store.push(letter)
    if @secret_word.include?(letter)
      @guess_string = @secret_word.tr("^#{@letter_store.join('')}", '_')
      @clue_string = @guess_string.split(//).join(' ')
    end
    @clue_string
  end

  def make_clue
    clue_string = []
    @secret_word.each_char { clue_string.push('_') }
    clue_string = clue_string.join(' ')
    @clue_string = clue_string
  end

  def guess_tracker
    puts '   . . . . . . . . . '
		puts "    Your guesses = #{@letter_store.join(' ')}"
    puts "   . . . . . . . . . "
  end

	def start_new_game
    select_word
    @game_length = @secret_word.length * 1.5
    introduction
    make_clue
    @letter_store = []
  end

  def guess(letter)
		puts "\nEnter a letter to guess the word "
		puts "or enter \'save\' to save your game to a file"
		if letter.length == 1 && !@letter_store.include?(letter)
			@letter = letter
    elsif @letter_store.include?(letter)
      until !@letter_store.include?(letter)
        puts "Letter already chosen. Please try again."
        letter = gets.chomp
      end
		end
	end

  def play_game
    i = @game_length.round
    while i > 0
      @countdown = "\nYou have #{i} turns remaining."
      puts @countdown
      puts @clue_string
      guess = gets.chomp
			guess(guess)
			check_letter(@letter)
      guess_tracker
      @game_length = i - 1
			self.save(guess)
			if @guess_string == @secret_word
        puts "\nYOU WIN!!!"
        break
      end
      i -= 1
    end
		puts "The secret word was #{@secret_word}."
  end
end