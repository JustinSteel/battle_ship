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

  describe "#render" do
    before(:each) do
      @cell_1 = Cell.new("B4")
      @cell_2 = Cell.new("C3")
      @cruiser = Ship.new("Cruiser", 3)
    end

    it "returns string representation of cell" do
      expect(@cell_1.render).to eq(".")
      @cell_1.fire_upon
      expect(@cell_1.render).to eq("M")
    end

    it "changes string when ship is hit" do
      @cell_2.place_ship(@cruiser)

      expect(@cell_2.render).to eq(".")
     #expect(@cell_2.render(true)).to eq("S")

      @cell_2.fire_upon

      expect(@cell_2.render).to eq("H")
      expect(@cruiser.sunk?).to be(false)

      @cruiser.hit
      @cruiser.hit

      expect(@cruiser.sunk?).to be(true)

      expect(@cell_2.render).to eq("X")
    end



  end
end