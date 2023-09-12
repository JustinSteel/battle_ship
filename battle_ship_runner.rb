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
  @player_board = Board.new
  @computer_board = Board.new
  cruiser = Ship.new("Cruiser", 3)
  submarine = Ship.new("Submarine", 2)
  puts "\n Welcome to BATTLESHIP \n\n"
  puts "Enter p to play. Enter q to quit. <p/q>:"
  ans = gets.chomp
  if ans == "p"
    #computer place ships
    computer_place_ships(submarine)
    computer_place_ships(cruiser)
    
    puts "\n I have laid out my ships on the grid.
    You now need to lay out your two ships.
    The Cruiser is three units long and the Submarine is two units long. \n\n"
    #computer has placed ships, asks for player's input.
      print @player_board.render
        
      puts "Enter the squares for the Cruiser (3 spaces): example: A1 A2 A3"
        # require 'pry'; binding.pry
    #creates a holder for coordinates, which will be emptied if cords are invalid
        cords = []
        until @player_board.place(cruiser, cords)
          ans = gets.chomp
          cords = ans.upcase.split(" ")
          if @player_board.valid_placement?(cruiser, cords) == false
            cords = []
            p  "Invalid placement, try again."
          end
        end
        @player_board.place(cruiser, cords)
        print @player_board.render(true)
    
      puts "Enter the squares for the Submarine (2 spaces): example: A2 A3"
      #creates a holder for coordinates, which will be emptied if cords are invalid
        cords = []
        until @player_board.valid_placement?(submarine, cords)
          ans = gets.chomp
          cords = ans.upcase.split(" ")
          if @player_board.valid_placement?(submarine, cords) == false
            cords = []
            p  "Invalid placement, try again."
          end
        end
        @player_board.place(submarine, cords)
        print @player_board.render(true)
        
      end
          
end

def computer_place_ships(ship)
  cords = []
  number_or_letter = ["letter", "number"]
  letter_range = ("A".."Z").to_a
  
  until @computer_board.place(ship, cords)
    first_cord = @computer_board.cells.to_a.sample.first
    split_cord = first_cord.chars
    sample = number_or_letter.sample
    
    if sample == "letter"
      letters_array = (split_cord[0]..(letter_range[letter_range.find_index(split_cord[0]) + (ship.length - 1)])).to_a
      cords = []
      letters_array.each do |letter|
        cords << [letter, split_cord[1]].join
      end
      
    elsif sample == "number"
      numbers_array = (split_cord[1].to_i..(split_cord[1].to_i + (ship.length - 1))).to_a
      cords = []
      numbers_array.each do |number|
        cords << [split_cord[0], number].join
      end
    end
    #  require 'pry'; binding.pry
  end
  print @computer_board.render(true)
end

start

#loop
#render computer board
#take input on firing
#updated computer board with fired upon

#computer takes a shot
#updates on player board
#renders player board
until @player_board.cruiser.sunk = true && @player_board.submarine.sunk = true ||
  @computer_board.cruiser.sunk = true && @computer_board.submarine.sunk = true
  fired_upon_cell = @player_board.cells.to_a.sample
  puts "My turn. I fire upon #{fired_upon_cell}"
  puts "choose a cell to fire upon:\n"
  print @computer_board.render(true)

  input = gets.chomp



end