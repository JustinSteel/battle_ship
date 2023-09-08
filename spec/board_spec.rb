require './lib/board'
require './lib/ship'

RSpec.describe Board do
  before(:each) do
    @board = Board.new
  end

  describe '#board' do
    it 'creates cells when board is made' do
      expect(@board.cells).is_a?(Hash)
      # require 'pry'; binding.pry
      expect(@board.cells.keys.count).to eq(16)
      # expect(@board.cells.values).to be_a(Cell)
      
    end

    it 'validates coordinates' do
      expect(@board.valid_coordinate?("A1")).to be true
      expect(@board.valid_coordinate?("D4")).to be true
      expect(@board.valid_coordinate?("A5")).to be false
      expect(@board.valid_coordinate?("E1")).to be false
      expect(@board.valid_coordinate?("A22")).to be false
    end
  end

  describe 'validate placement' do
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
      # require 'pry'; binding.pry
      expect(@board.valid_placement?(@cruiser, ["A1", "A2", "A4"])).to be false
      expect(@board.valid_placement?(@submarine, ["A1", "C1"])).to be false
      expect(@board.valid_placement?(@cruiser, ["A3", "A2", "A1"])).to be false
      expect(@board.valid_placement?(@submarine, ["C1", "B1"])).to be false
    end
  end
end
