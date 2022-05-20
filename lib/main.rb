require './lib/game'
require './lib/Save_Game'
require 'yaml'
require 'time'

include Save_Game

game = load_game
