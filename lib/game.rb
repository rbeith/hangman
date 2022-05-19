require './lib/Save_Game'

class Game
  include Save_Game

	def initialize(player)
		@player = player
	end

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
    @secret_word = dictionary_array.sample
  end

  def check_letter(letter)
    @letter_store = []
    @letter_store.push(letter)
    if @secret_word.include?(letter)
      @guess_string = @secret_word.tr("^#{@letter_store.join('')}", '_')
      @clue_string = @guess_string.split(//).join(' ')
    end
    puts @clue_string
  end

  def make_clue
    clue_string = []
    @secret_word.each_char { clue_string.push('_') }
    clue_string = clue_string.join(' ')
    @clue_string = clue_string
  end

  def guess_tracker
    puts '. . . . . . . . . . '
		puts "Your guesses = #{@letter_store.join(' ')}"
    puts ". . . . . . . . . . "
  end

	def play_game
    select_word
    introduction
    i = 10
    while i > 0
      puts "You have #{i} turns remaining."
      puts @clue_string
			@player.guess
			check_letter(@player.letter)
      guess_tracker
			win_condition
			self.save
			i -= 1
    end
		puts "The secret word was #{@secret_word}."
  end

	def win_condition
		if @guess_string == @secret_word
			puts "YOU WIN!!"
		end
	end
end