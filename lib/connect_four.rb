require 'grid'
require 'player'

class ConnectFour
  attr_accessor :grid

  def initialize
    @grid = Grid.new
    introduction
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
end