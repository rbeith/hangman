require './lib/player'
require './lib/game'
require 'yaml'

game = Game.new(Player.new)
game.play_game
