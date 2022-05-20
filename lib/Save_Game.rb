module Save_Game
  def save(input)
		if input.downcase == 'save'
      puts "\nGame saved."
      puts "\n"
			File.open("save.yml", 'w') { |file| file.write(self.to_yaml) }
		end 
	end  

  def load_game
    puts "\nTo load the last saved game, enter \'y\'."
    puts 'Or press any key to continue.'
    input = gets.chomp
    if input == 'y'
      game = YAML.load_file('save.yml')
      game.play_game
    else game = Game.new
      game.start_new_game
      game.play_game
    end
  end
end