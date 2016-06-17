require 'spec_helper'
require 'connect_four'

describe ConnectFour do
  before(:context) { @game = ConnectFour.new }

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

    it "returns true for 'Y'" do
      expect(@game.valid_color_choice?('Y')).to be_truthy
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
        "\nPlayer 1, select your color, R (red) or Y (yellow): ").to_stdout
    end

    context "receives valid input" do
      it "sets player one @color to symbol" do
        @game.color_prompt
        expect(@game.players[0].color).to eq :red
      end

      it "sets player two @color to symbol" do
        @game.color_prompt
        expect(@game.players[1].color).to eq :yellow
      end
    end
  end

  describe "#move_accept" do
    before do
      allow(@game).to receive(:gets).and_return '2'
    end

    it "displays move prompt" do
      expect{ @game.move_accept}.to output(
        "\n"+"   ".color(@game.players[0].color)+" - Choose a column (1-7): ").to_stdout
    end

    it "receives valid input" do
      expect(@game.move_accept).to eql true
    end
  end
end