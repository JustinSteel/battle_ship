class Board
  attr_accessor :cells

  def initialize
    @cells = {
      "A1" => Cell.new("A1"),
      "A2" => Cell.new("A2"),
      "A3" => Cell.new("A3"),
      "A4" => Cell.new("A4"),
      "B1" => Cell.new("B1"),
      "B2" => Cell.new("B2"),
      "B3" => Cell.new("B3"),
      "B4" => Cell.new("B4"),
      "C1" => Cell.new("C1"),
      "C2" => Cell.new("C2"),
      "C3" => Cell.new("C3"),
      "C4" => Cell.new("C4"),
      "D1" => Cell.new("D1"),
      "D2" => Cell.new("D2"),
      "D3" => Cell.new("D3"),
      "D4" => Cell.new("D4")
    }
  end

  def valid_coordinate?(coordinate)
    @cells.include?(coordinate)
  end

  def valid_placement?(ship, coordinates)
    cords_subarray = coordinates.each_slice(1).to_a
    cords_split = cords_subarray.map do |n|
      n[0].chars
    end
    
    if ship.length == coordinates.length
      if ship.length == 2 && coordinates.length == 2 
        if ((cords_split[0][0] == cords_split[1][0]) && ([cords_split[0][1].ord, cords_split[1][1].ord].each_cons(2).any? { |ordinal1, ordinal2| ordinal2 == ordinal1 + 1 })) || (cords_split[0][1] == cords_split[1][1]) && ([cords_split[0][0].ord, cords_split[1][0].ord].each_cons(2).any? { |ordinal1, ordinal2| ordinal2 == ordinal1 + 1 })
          return true
        elsif !((cords_split[0][0] == cords_split[1][0]) && ([cords_split[0][1].ord, cords_split[1][1].ord].each_cons(2).any? { |ordinal1, ordinal2| ordinal2 == ordinal1 + 1 })) || (cords_split[0][1] == cords_split[1][1]) && ([cords_split[0][0].ord, cords_split[1][0].ord].each_cons(2).any? { |ordinal1, ordinal2| ordinal2 == ordinal1 + 1 })
          return false
        end
      else
      end

      if ship.length == 3 && coordinates.length == 3 
        if ((cords_split[0][0] == cords_split[1][0] && cords_split[1][0] == cords_split[2][0]) && ([cords_split[0][1].ord, cords_split[1][1].ord, cords_split[2][1].ord].each_cons(2).all? { |ordinal1, ordinal2| ordinal2 == ordinal1 + 1 })) || (cords_split[0][1] == cords_split[1][1] && cords_split[1][1] == cords_split[2][1]) && ([cords_split[0][0].ord, cords_split[1][0].ord, cords_split[2][0].ord].each_cons(2).all? { |ordinal1, ordinal2| ordinal2 == ordinal1 + 1 })
          return true
        elsif !((cords_split[0][0] == cords_split[1][0] && cords_split[1][0] == cords_split[2][0]) && ([cords_split[0][1].ord, cords_split[1][1].ord, cords_split[2][1].ord].each_cons(2).all? { |ordinal1, ordinal2| ordinal2 == ordinal1 + 1 })) || (cords_split[0][1] == cords_split[1][1] && cords_split[1][1] == cords_split[2][1]) && ([cords_split[0][0].ord, cords_split[1][0].ord, cords_split[2][0].ord].each_cons(2).all? { |ordinal1, ordinal2| ordinal2 == ordinal1 + 1 })
          return false
        end
      else
      end
    else
      return false
    end
  end
end


# def valid_placement?(ship, coordinates)
#   return false if coordinates.length != ship.length || coordinates.uniq.length != ship.length
#   return false if (coordinates.map {|coordinate| coordinate[0]}.all? {|coordinate| coordinate == coordinates[0][0]} && 
#   coordinates.map{|coordinate| coordinate[1]}.all? {|coordinate| coordinate == coordinates[0][1]}).false?
#   # todo consecutive
#   return false if (coordinate.map {|coordinate| coordinate[0]}.all? {|coordinate| coordinate == [0][0]})
#   #split coordinate

#   #assign first half of coordinate to ordinal value
#   #convert ordinal value to range
#   #Each cons method
#   true
# end

# cords_array = coordinates.each_slice(1).to_a
# cords_split = new.map do |n|
#   n[0].chars
# end
# if coordinates.length == 2 && (cords_split[0][0] == cords_split[0][1] ||
#   cords_split[1][0] == cords_split[1][1])
#   return true
# elsif coordinates.length == 3 && (cords.split[0][0] == cords.split[0][1] == cords.split[0][2] ||
#   cords.split[1][0] == cords.split[1][1] == cords.split[1][2])
#   return true
# end
