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
    if ship.length == coordinates.length
       helper_method(coordinates)
    else
      false
    end
  end

  def helper_method(cords)
    letters = cords.map {|cord| cord[0]}
    numbers = cords.map {|cord| cord[1..-1].to_i}
    (letters.uniq.length == 1 && numbers == (numbers.first..numbers.last).to_a) ||
    (numbers.uniq.length == 1 && ("A"..letters.last).each_cons(cords.count).any? { |each| letters == each}) &&
    cords.all? {|cell| @cells[cell].empty?}
  end
end


