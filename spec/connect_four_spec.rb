require 'spec_helper'
require 'connect_four'

describe ConnectFour do
  before(:context) { @game = ConnectFour.new}

  describe "#initialize" do
    it "creates new instance of game" do
      expect(@game).to be_instance_of ConnectFour
    end

    it "creates a new grid (playing field)" do
      expect(@game.grid).to be_instance_of Grid
    end

    context "initialize players" do
      it "creates array with valid player objects" do
        expect(@game.players).to all(be_instance_of Player)
      end
    end
  end

  describe "#valid_color_choice?" do
    it "returns true for 'R'" do
      expect(@game.valid_color_choice?('R')).to be_truthy
    end

    it "returns true for 'L'" do
      expect(@game.valid_color_choice?('L')).to be_truthy
    end

    it "returns false for everything else" do
      expect(@game.valid_color_choice?('anything here')).to be_falsey
    end
  end

  describe "#color_prompt" do
    before do
      allow(@game).to receive(:gets).and_return "R"
    end

    it "displays color choice prompt" do
      expect{ @game.color_prompt }.to output(
        "\nPlayer 1, select your color, R (red) or Y (yellow):").to_stdout
    end

    context "receives valid input" do
      it "sets player one @color to symbol" do
        @game.color_prompt
        expect(@game.players[0].color).to eq :R
      end

      it "sets player two @color to symbol" do
        @game.color_prompt
        expect(@game.players[1].color).to eq :L
      end
    end
  end
end