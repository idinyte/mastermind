require_relative 'game.rb'
require_relative 'human_guessing'
require_relative 'computer_guessing'
require_relative 'display.rb'


include Display
system("clear")
Display.instructions

Game.new

