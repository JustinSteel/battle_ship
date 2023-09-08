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

  def render(ship = false)
    if @fired_upon == false && ship == true
      return "S"
    elsif @fired_upon == false
      return "."
    elsif @fired_upon == true && empty? == true
      return "M"
    elsif @fired_upon == true && empty? == false && @ship.health == 0
      return "X"
    elsif @fired_upon == true && empty? == false
      return "H"
    end

  end

end