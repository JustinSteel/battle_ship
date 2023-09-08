class Cell
  attr_reader   :coordinate
  attr_accessor :ship

  def initialize(coordinate)
    @ship       = nil
    @fired_upon = false
    @coordinate = coordinate
  end

  def empty?
    if @ship == nil
      true
    else
      false
    end
  end

  def place_ship(ship_type)
    @ship = ship_type
  end

  def fired_upon?
    @fired_upon
  end

  def fire_upon
    @fired_upon = true
     if empty? == false 
      ship.hit
     else
      empty? == true
      return "Missed Me" 
     end
  end
end