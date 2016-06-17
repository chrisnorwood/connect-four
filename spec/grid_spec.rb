require 'grid'
require 'string'

describe Grid do
  before do
    @grid = Grid.new
  end

  describe "#initialize" do
    it "creates @data, an array of 7 arrays for columns" do
      expect(@grid.data.size).to eql 7
    end

    it "creates empty arrays (stacks) for the columns" do
      expect(@grid.data.all? { |i| i == [] }).to eq true
    end
  end

  describe "#display" do
    
    context "when there is nothing to display" do
      it "displays an empty grid" do
        expect{ @grid.display }.to output(
          "\n- 1 - 2 - 3 - 4 - 5 - 6 - 7 -\n"+
            "|   |   |   |   |   |   |   |\n"+
            "|---------------------------|\n"+
            "|   |   |   |   |   |   |   |\n"+
            "|---------------------------|\n"+
            "|   |   |   |   |   |   |   |\n"+
            "|---------------------------|\n"+
            "|   |   |   |   |   |   |   |\n"+
            "|---------------------------|\n"+
            "|   |   |   |   |   |   |   |\n"+
            "|---------------------------|\n"+
            "|   |   |   |   |   |   |   |\n"+
            "|---------------------------|\n\n").to_stdout
      end
    end
    
    context "when there is data (mid-game)" do
      before do 
        @grid.data[0] = [:red, :yellow]
        @grid.data[1] = [:yellow]
      end

      it "displays a grid with pieces" do
        expect { @grid.display }.to output(
          "\n- 1 - 2 - 3 - 4 - 5 - 6 - 7 -\n"+
            "|   |   |   |   |   |   |   |\n"+
            "|---------------------------|\n"+
            "|   |   |   |   |   |   |   |\n"+
            "|---------------------------|\n"+
            "|   |   |   |   |   |   |   |\n"+
            "|---------------------------|\n"+
            "|   |   |   |   |   |   |   |\n"+
            "|---------------------------|\n"+
            "|"+"   ".color(:red)+"|   |   |   |   |   |   |\n"+
            "|---------------------------|\n"+
            "|"+"   ".color(:yellow)+"|"+"   ".color(:yellow)+"|   |   |   |   |   |\n"+
            "|---------------------------|\n\n"
          ).to_stdout
      end
    end
  end

  describe "#move" do
    context "when the column is not full" do
      before do
        @grid.data[5] = []
      end

      it "adds pieces to the column" do
        # adds red piece to column 3
        # 2 is index of column 3 in data, 5 being the bottom piece in the stack
        expect{ @grid.move(4, :red) }.to change{ @grid.data[3].size }.from(0).to(1)
      end
    end

    context "when the column is full" do
      before do
          @grid.data[4] = [:red, :yellow, :red, :red, :yellow, :red]
      end
      
      it "does not add piece to column" do
        expect{ @grid.move(5, :red) }.not_to change { @grid.data[4].size }
      end

      it "returns false" do
        expect(@grid.move(5, :red)).to eq false
      end
    end
  end

  describe "#column_full?" do
      before do
        @grid.data[2] = [:yellow, :yellow, :red, :yellow, :red, :red]
        @grid.data[5] = []
      end

      it "returns true if column is full" do
        expect(@grid.column_full?(3)).to eq true
      end

      it "returns false if column is not full" do
        expect(@grid.column_full?(6)).to eq false
      end
  end

  describe "#winner?" do
    context "when winning combo. exists" do
      before do
        @grid.data = [[:red, :red, :yellow, :red],
                      [:red, :red, :red, :red],
                      [:red, :yellow, :yellow],
                      [:red, :red, :yellow, :red],
                      [:yellow],
                      [:red],
                      [:yellow]]
      end

      it "returns color symbol of winning line" do
        expect(@grid.winner?).to be_truthy
        expect(@grid.winner?).to eq :red
      end
    end

    context "when winning combo. does not exist" do
      before do
        @grid.data = [[:red, :red, :yellow, :yellow],
                      [:red, :red, :yellow, :red],
                      [:red],
                      [:red, :red, :yellow, :yellow],
                      [:yellow],
                      [:red],
                      [:yellow]]
      end

      it "returns false" do
        expect(@grid.winner?).to eq false
      end
    end
  end

  describe "#vertical_win?" do
    context "when any four in row vertically" do
      before do
        @grid.data[0] = [:red, :red, :red, :red, :yellow]
      end

      it "returns true" do
        expect(@grid.vertical_win?).to eq true
      end
    end

    context "when no four in row vertically" do
      before do
        @grid.data = [[], [], [], [], [], [], []]
        @grid.data[3] = [:yellow, :yellow, :red, :red, :red, :yellow]
      end

      it "returns false" do
        expect(@grid.vertical_win?).to eq false
      end
    end
  end

  describe "#horizontal_win?" do
    before do
      @grid.data = [[:yellow, :yellow, :red, :red, :red, :yellow],
                    [:yellow, :yellow, :red, :red, :yellow],
                    [:yellow, :yellow, :red, :yellow, :red],
                    [:yellow, :yellow, :yellow, :red, :red, :red],
                    [:yellow, :red, :red, :red, :yellow, :red],
                    [:yellow, :red, :red, :red, :red],
                    [:red, :red, :red, :yellow]]
    end
    context "when four horizontally connected" do
      it "returns true" do
        expect(@grid.horizontal_win?).to eq true
      end
    end

    context "when four not horizontally connected" do
      before do
        @grid.data = [[:red, :red, :yellow, :yellow],
                      [:red, :red, :red, :red],
                      [:red],
                      [:red, :red, :yellow, :yellow],
                      [:yellow],
                      [:red],
                      [:yellow]]
      end

      it "returns false" do
        expect(@grid.horizontal_win?).to eq false
      end
    end
  end

  describe "#diagonal_win?" do
    context "when diagonal match occurs" do
      before do
        @grid.data = [[:red, :red, :yellow, :red],
                      [:red, :red, :red, :red],
                      [:red, :yellow, :yellow],
                      [:red, :red, :yellow, :red],
                      [:yellow],
                      [:red],
                      [:yellow]]
      end

      it "returns true" do
        expect(@grid.diagonal_win?).to eq true
      end
    end

    context "when diagonal match does not occur" do
      before do
        @grid.data = [[:yellow, :red],
                      [:red, :red, :red],
                      [:yellow, :yellow],
                      [:red, :red, :yellow, :red],
                      [:yellow],
                      [:red],
                      [:yellow]]
      end

      it "returns false" do
        expect(@grid.diagonal_win?).to eq false
      end
    end
  end

  describe "#draw?" do
  end
end