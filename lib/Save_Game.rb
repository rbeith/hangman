module Save_Game
  def save
    puts "\n"
    puts "    * * * * * * * *"
    puts "      Game saved"
    puts "    * * * * * * * *"
    puts "\n"
    file_name = Time.new.asctime
    File.open("saved_games/#{file_name}.yml", 'w') { |file| file.write(self.to_yaml) }
  end

  def load_game
    puts "\nTo see a list of saved games, enter \'y\'."
    puts 'Or press any key to continue.'
    input = gets.chomp
    if input == 'y'
      choose_file
      game = YAML.safe_load_file("saved_games/#{@game_to_load}", permitted_classes: [Game])
      game.play_game
    else game = Game.new
      game.start_new_game
      game.play_game
    end
  end

  def choose_file
    saved_games = []
    game_dir = Dir.open("saved_games")
    game_dir.each_child { |file| saved_games.push(file) }
    puts "\nHere is a list of saved games:"
    saved_games.each_with_index { |file, index| puts "\n#{index + 1}: #{file}" }
    puts "Enter the number to open the saved game."
    input = gets.chomp.to_i
    @game_to_load = saved_games[input - 1]
  end
end
