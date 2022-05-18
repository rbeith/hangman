class Player < Game
	attr_accessor :guess

  def initialize
    @guess
  end

	def guess
		puts "Enter a letter to guess the word"
		letter = gets.chomp
	end

end
