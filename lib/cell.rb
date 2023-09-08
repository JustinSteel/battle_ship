class Cell
  attr_reader   :coordinate
  attr_accessor :ship

  def initialize(coordinate)
    @ship       = false
    @fired_upon = false
  end

  def empty?
    if @ship == true
      false
    else
      true
    end
  end

  def place_ship(ship_type)
    @ship = true
  end

  def fired_upon?
    @fired_upon
  end

  def fire_upon
    @fired_upon = true
     if @ship == true  
      ship.hit
     else
      @ship == false
      return "Missed Me" 
     end
  end
end