require './lib/Save_Game'

class Game
  include Save_Game

	def start_new_game
    select_word
    introduction
    make_clue
    @letter_store = []
  end

	def play_game
    i = @game_length.round
    while i > 0
      @countdown = "\nYou have #{i} turns remaining."
      puts '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'
      puts @countdown
      puts "\n"
      puts @clue_string
      guess_tracker
			@letter = ''
			player_guess
			check_letter(@letter)
      @game_length = i - 1
			check_win
			if @break_loop == true
        break
      end
      i -= 1
			if i == 0
			 game_over
			end
    end
  end

	private

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

	def introduction
    puts 'Let\'s play a game of Hangman!'
    puts 'Select difficulty'
    puts '  1 - Easy'
    puts '  2 - Medium'
    puts '  3 - Hard'
    set_difficulty
	end

	def make_clue
    clue_string = []
    @secret_word.each_char { clue_string.push('_') }
    clue_string = clue_string.join(' ')
    @clue_string = clue_string
  end

  def set_difficulty
    selection = gets.chomp
    case selection
    when '1'
      @game_length = @secret_word.length * 2
    when '2'     
      @game_length = @secret_word.length * 1.5
    when '3'
      @game_length = @secret_word.length * 1
    else
      puts 'Please enter 1, 2, or 3 to select the difficulty level'
      set_difficulty
    end
  end

	def guess_tracker
    puts "\n"
    puts '. . . . . . . . . . . . . . . . . . .'
		puts "Letters guessed: #{@letter_store.join(' ')}"
    puts ". . . . . . . . . . . . . . . . . . ."
  end

	def player_guess
		puts "\nEnter a letter to guess the word "
		puts "or enter \'save\' to save your game to a file"
    puts "\nGuess:"
    guess = gets.chomp.downcase
		if guess == ""
			puts "?!?!? What's your GUESS! ?!?!?"
			player_guess
		end
		if guess.length == 1 && !@letter_store.include?(guess)
			@letter = guess
    elsif @letter_store.include?(guess)
			puts 'x x x x x x x x x x x x x x x x x x x x x x'
			puts "\nYou already chose \'#{guess},\' please try again."
			puts "\nx x x x x x x x x x x x x x x x x x x x x x"
			player_guess
    elsif guess.downcase == 'save'
			@letter = 0
      save
			@break_loop = true
    end
	end

  def check_letter(letter)
		if !@letter_store.include?(letter)
			@letter_store.push(letter)
		end
		if @secret_word.include?(letter.to_s)
			@guess_string = @secret_word.tr("^#{@letter_store.join('')}", '_')
			@clue_string = @guess_string.split(//).join(' ')
		end
		@clue_string
  end
	
  def check_win
    if @guess_string == @secret_word
			puts "\nYOU WIN!!!"
			puts "\n          YOU WIN!!!"
			puts "\n                     YOU WIN!!!"
			reveal_secret
      @break_loop = true
		end
  end
	
	def game_over
		puts "\n   ---GAME OVER---"
		puts "\n  ...No luck this time."
		reveal_secret
	end

	def reveal_secret
		puts "\nThe secret word was #{@secret_word.upcase}.\n\n"
	end
end
