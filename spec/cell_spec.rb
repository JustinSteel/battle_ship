require './lib/cell'
require './lib/ship'

RSpec.describe Cell do
  describe '#cell' do

    before(:each) do
      @cell = Cell.new("B4")
    end

    it 'checks the coordinate of a cell' do
      expect(@cell.coordinate).to eq("B4")
    end

    it 'has no ship by default' do
      expect(@cell.ship).to eq(nil)
    end

    it 'is empty by default' do
      expect(@cell.empty?).to eq(true)
    end

    it 'places a ship' do
      cruiser = Ship.new("Cruiser", 3)
      @cell.place_ship(cruiser)
      expect(@cell.ship).to eq(cruiser)
      expect(@cell.empty?).to eq(false)
    end

    it 'fires upon' do
      cruiser = Ship.new("Cruiser", 3)
      @cell.place_ship(cruiser)
      expect(@cell.fired_upon?).to eq(false)
      @cell.fire_upon
      expect(@cell.ship.health).to eq(2)
      expect(@cell.fired_upon?).to eq(true)
    end
  end
end