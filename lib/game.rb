class Game

	def initialize
		@computer = Computer.new
		@player = Player.new
		introduction
		play_game
	end
	
	def introduction
    puts 'Let\'s play a game of Hangman!'
	end
	
	def play_game
    i = 10
    while i > 0
      puts "You have #{i} turns remaining."
			puts "Your guesses = #{@computer.letter_store.join(' ')}"
			@guess = @player.guess
			@computer.check_letter(@guess)
			win_condition
			i -= 1
    end
		puts "The secret word was #{@computer.secret_word}."
  end

	def win_condition
		if @computer.guess_string == @computer.secret_word
			puts "YOU WIN!!"
		end
	end
end