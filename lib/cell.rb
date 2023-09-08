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

  def render
    if @fired_upon == false
      return "."
    elsif @fired_upon == true && empty? == true
      return "M"
    elsif @fired_upon == true && empty? == false
      return "H"
    elsif @fired_upon == true && empty? == false && @ship.health == 0
      return "X"
    end

  end
end