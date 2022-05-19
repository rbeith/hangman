module Save_Game
  def serialize
	YAML.dump(self)
  end
  
  def save
		p self
		puts 'Would you like to save your game?'
		puts 'Press \'s\' to save'
		input = gets.chomp 
		if input == 's'
			File.open("save.yml", 'w') { |file| file.write(self.to_yaml) }
		end 
	end  
end