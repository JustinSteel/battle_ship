require './lib/board'

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
end