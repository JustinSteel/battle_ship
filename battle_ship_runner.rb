require './lib/board'
require './lib/ship'
require './lib/cell'



# @board = Board.new

# def computer_ships
#   ship_creation
#   @board.place(@cruiser, ["A1", "A2", "A3"])
#   p @board.render
#   # random = @board.cells.to_a.sample.first
#   # ship_creation
#   # @board.place_ship(@cruiser, random)
# end

# def ship_creation
#   @cruiser = Ship.new("Cruiser", 3)
#   @submarine = Ship.new("Submarine", 2)
# end

def start
  @board = Board.new
  @cruiser = Ship.new("Cruiser", 3)
  @submarine = Ship.new("Submarine", 2)
  puts "\n Welcome to BATTLESHIP \n\n"
  puts "Enter p to play. Enter q to quit. <p/q>:"
    ans = gets.chomp
    if ans == "p"
      #computer place ships
      computer_place_ships
      
      puts "\n I have laid out my ships on the grid.
      You now need to lay out your two ships.
      The Cruiser is three units long and the Submarine is two units long. \n\n"
        p @board.render
      
      puts "Enter the squares for the Cruiser (3 spaces): example: A1 A2 A3"
        # require 'pry'; binding.pry
        until @board.valid_placement?(@cruiser, cords)
          ans = gets.chomp
          cords = ans.upcase.split(" ")
          if @board.valid_placement?(@cruiser, cords) == false
            p  "Invalid placement, try again."
          end
        end
        @board.place(@cruiser, cords)
        p @board.render(true)
    
      puts "Enter the squares for the Submarine (2 spaces): example: A2 A3"
      until @board.valid_placement?(@submarine, cords)
        ans = gets.chomp
        cords = ans.upcase.split(" ")
        if @board.valid_placement?(@submarine, cords) == false
          p  "Invalid placement, try again."
        end
      end
      @board.place(@submarine, cords)
      p @board.render(true)
    
    end
          
end
def computer_place_ships
  cords = []
  number_or_letter = ["letter", "number"]
  
  until @board.valid_placement?(@cruiser, cords)
    first_cord = @board.cells.to_a.sample.first
    split_cord = first_cord.chars
    if number_or_letter.sample == "letter"
      letters_array = (split_cord[0].."D").to_a
      letters_array.each do |letter|
        cords << [letter, split_cord[1]].join
      end
    elsif number_or_letter.sample == "number"
      numbers_array = (split_cord[1].to_i..4).to_a
      numbers_array.each do |number|
        cords << [split_cord[0], number].join
      end
    end
  
    #require 'pry'; binding.pry
    @board.place(@cruiser, cords)
  end
  p @board.render(true)
end
start