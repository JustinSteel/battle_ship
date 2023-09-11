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
        
        puts "\n I have laid out my ships on the grid.
        You now need to lay out your two ships.
        The Cruiser is three units long and the Submarine is two units long. \n\n"
         p @board.render
        
        puts "Enter the squares for the Cruiser (3 spaces):"
         ans = [gets.chomp.capitalize]
        @board.place(@cruiser, ans)
        p @board.render(true)
      
      end
          
end
start