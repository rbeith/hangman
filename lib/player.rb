class Player
attr_reader :letter

	def guess
		puts "Enter a letter to guess the word"
		@letter = gets.chomp
	end
end
