require_relative 'display.rb'

class Game
  
  include Display

  def initialize()
    Display.choose_game_mode_message
    choose_game_mode == 1 ? CodeBreaker.new : CodeMaker.new
  end

  def choose_game_mode
    input = gets.chomp
    return input.to_i if input == "1" || input == "2"
    puts "\e[41m Incorrect input. Please type either 1 or 2 to select the game mode \e[0m"
    choose_game_mode
  end
end

