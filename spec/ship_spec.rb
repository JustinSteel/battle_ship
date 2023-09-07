require './lib/ship'
require 'pry'

RSpec.describe Ship do
  describe '#Ship' do
    before(:each) do
    @cruiser = Ship.new("Cruiser", 3)
    end

    it 'checks ship is instance of Ship' do
      expect(@cruiser).to be_a Ship
    end

    it 'ship starting details details' do
      expect(@cruiser.name).to eq("Cruiser")
      
      expect(@cruiser.length).to eq(3)
      expect(@cruiser.health).to eq(3)
      expect(@cruiser.sunk?).to be false
    end

    it 'loses health after hit and can sink' do
      @cruiser.hit
      expect(@cruiser.health).to eq(2)

      @cruiser.hit
      expect(@cruiser.health).to eq(1)
      expect(@cruiser.sunk?).to be false

      @cruiser.hit
      expect(@cruiser.sunk?).to be true
    end
  end
end