require './lib/board'
require './lib/ship'
require './lib/cell'

RSpec.describe Board do
  describe '#board' do
    before(:each) do
      @board = Board.new
    end

    it 'creates cells when board is made' do
      expect(@board.cells).is_a?(Hash)
      expect(@board.cells.keys.count).to eq(16)      
    end

    it 'validates coordinates' do
      expect(@board.valid_coordinate?("A1")).to be true
      expect(@board.valid_coordinate?("D4")).to be true
      expect(@board.valid_coordinate?("A5")).to be false
      expect(@board.valid_coordinate?("E1")).to be false
      expect(@board.valid_coordinate?("A22")).to be false
    end
  end

  describe '#validate_placement' do
    before(:each) do
      @board = Board.new
      @cruiser = Ship.new("Cruiser", 3)
      @submarine = Ship.new("Submarine", 2) 
    end

    it 'checks coordinates are same length as ship' do
      expect(@board.valid_placement?(@cruiser, ["A1", "A2"])). to be false
      expect(@board.valid_placement?(@submarine, ["A2", "A3", "A4"])). to be false
    end

    it 'checks if coordinates are consecutive' do
      expect(@board.valid_placement?(@cruiser, ["A1", "A2", "A4"])).to be false
      expect(@board.valid_placement?(@submarine, ["A1", "C1"])).to be false
      expect(@board.valid_placement?(@cruiser, ["A3", "A2", "A1"])).to be false
      expect(@board.valid_placement?(@submarine, ["C1", "B1"])).to be false
    end

    it 'checks that coordinates are not diagonal' do
      expect(@board.valid_placement?(@cruiser, ["A1", "B2", "C3"])).to be false
      expect(@board.valid_placement?(@submarine, ["C2", "D3"])).to be false
    end

    it 'checks that valid placement returns true' do
      expect(@board.valid_placement?(@submarine, ["A1", "A2"])).to be true
      expect(@board.valid_placement?(@cruiser, ["B1", "C1", "D1"])).to be true
    end
  end

  describe '#place' do 
    before(:each) do
      @board = Board.new
      @cruiser = Ship.new("Cruiser", 3)
    end

    it 'places ship' do 
      @board.place(@cruiser, ["A1", "A2", "A3"]) 
      cell_1 = @board.cells["A1"] 
      cell_2 = @board.cells["A2"]
      cell_3 = @board.cells["A3"]
      expect(cell_1.ship).to eq(@cruiser)
      expect(cell_2.ship).to eq(@cruiser)
      expect(cell_3.ship).to eq(@cruiser)
      expect(cell_3.ship == cell_2.ship).to be true
    end

    it 'will not overlap ships' do
      @board.place(@cruiser, ["A1", "A2", "A3"])
      @submarine = Ship.new("Submarine", 2) 
      expect(@board.valid_placement?(@submarine, ["A1", "B1"])).to be false
    end
  end

  describe '#Render' do
    before(:each) do
      @board = Board.new
      @cruiser = Ship.new("Cruiser", 3)
      @board.place(@cruiser, ["A1", "A2", "A3"])
    end

    it 'renders board' do
      expect(@board.render).to eq(
      "  1 2 3 4 \n" +
      "A . . . . \n" +
      "B . . . . \n" +
      "C . . . . \n" +
      "D . . . . \n"  
      )
    end

    it 'renders board with ships unhidden' do
      expect(@board.render(true)).to eq(
      "  1 2 3 4 \n" +
      "A S S S . \n" +
      "B . . . . \n" +
      "C . . . . \n" +
      "D . . . . \n"
      )
      print @board.render
    end

    it 'sinks a ship' do
      cell_1 = @board.cells["A1"] 
      cell_2 = @board.cells["A2"]
      cell_3 = @board.cells["A3"]
      cell_4 = @board.cells["D4"]
      cell_1.fire_upon
      cell_2.fire_upon
      cell_3.fire_upon
      cell_4.fire_upon
      expect(@board.render).to eq(
      "  1 2 3 4 \n" +
      "A X X X . \n" +
      "B . . . . \n" +
      "C . . . . \n" +
      "D . . . M \n"  
      )
    end
  end
end
