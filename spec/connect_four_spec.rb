require 'connect_four'

describe ConnectFour do
  before(:context) { @game = ConnectFour.new}

  context "new game" do
    it "creates new instance of game" do
      expect(@game).to be_instance_of ConnectFour
    end

    it "creates a new grid (playing field)" do
      expect(@game.grid).to be_instance_of Grid
    end

    it "displays introduction message" do
      expect{ @game.introduction }.to output(
        "\n
         _____                             _    ______               
        /  __ \\                           | |   |  ___|              
        | /  \\/ ___  _ __  _ __   ___  ___| |_  | |_ ___  _   _ _ __ 
        | |    / _ \\| '_ \\| '_ \\ / _ \\/ __| __| |  _/ _ \\| | | | '__|
        | \\__/\\ (_) | | | | | | |  __/ (__| |_  | || (_) | |_| | |   
         \\____/\\___/|_| |_|_| |_|\\___|\\___|\\__| \\_| \\___/ \\__,_|_|").to_stdout
    end
  end
end