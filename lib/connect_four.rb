require 'grid'
require 'player'

class ConnectFour
  attr_accessor :grid, :players

  def initialize
    @grid = Grid.new
    @players = [Player.new, Player.new]
    introduction
  end

  def play
    introduction
    color_prompt
    @grid.display
  end

  def introduction
    print "\n
           _____                             _    ______               
          /  __ \\                           | |   |  ___|              
          | /  \\/ ___  _ __  _ __   ___  ___| |_  | |_ ___  _   _ _ __ 
          | |    / _ \\| '_ \\| '_ \\ / _ \\/ __| __| |  _/ _ \\| | | | '__|
          | \\__/\\ (_) | | | | | | |  __/ (__| |_  | || (_) | |_| | |   
           \\____/\\___/|_| |_|_| |_|\\___|\\___|\\__| \\_| \\___/ \\__,_|_|"
  end

  # Prompts player 1 for color choice
  # if choice valid, it sets the color symbols for both players,
  # else it prints error and recursively calls itself
  def color_prompt
    print "\nPlayer 1, select your color, R (red) or Y (yellow):"
    choice = gets.chomp.upcase
    if valid_color_choice?(choice)
      case choice
      when "R"
        @players[0].color, @players[1].color = :red, :yellow
      when "L"
        @players[0].color, @players[1].color = :red, :yellow
      end
    else
      puts "Invalid choice, please enter R or Y\n"
      color_prompt
    end
  end

  def valid_color_choice?(color)
    return true if color == 'R' or color == 'Y'
    false
  end
end