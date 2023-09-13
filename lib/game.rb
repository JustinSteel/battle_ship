require './lib/board'
require './lib/ship'
require './lib/cell'

class Game
  attr_reader :player_board, :computer_board

  def initialize
    @player_board = Board.new
    @computer_board = Board.new
    @com_cruiser = Ship.new("Cruiser", 3)    
    @com_submarine = Ship.new("Submarine", 2)
    @p_cruiser = Ship.new("Cruiser", 3)    
    @p_submarine = Ship.new("Submarine", 2)
    main_menu
  end

  def main_menu
    puts "\n Welcome to BATTLESHIP \n\n"
    puts "Enter p to play. Enter q to quit. <p/q>:"

    ans = gets.chomp
    if ans == "p"
      start
    elsif ans == "q"
      "goodbye"
    end
  end

  def start
    computer_place_ships(@com_submarine)
    computer_place_ships(@com_cruiser)
    puts "=============COMPUTER BOARD=============\n"
    print @computer_board.render(true) 
    puts "\n I have laid out my ships on the grid.
    You now need to lay out your two ships.
    The Cruiser is three units long and the Submarine is two units long. \n\n"
      #computer has placed ships, asks for player's input.
    puts "==============PLAYER BOARD==============\n"
    print @player_board.render
    cruiser_chooser
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
    end
  end

  def cruiser_chooser
    puts "Enter the squares for the Cruiser (3 spaces): example: A1 A2 A3" 
    cords = []
    until @player_board.place(@p_cruiser, cords)
      ans = gets.chomp
      cords = ans.upcase.split(" ")
      if @player_board.valid_placement?(@p_cruiser, cords) == false
        cords = []
        p  "Invalid placement, try again."
      end
    end
    @player_board.place(@p_cruiser, cords)
    puts "==============PLAYER BOARD==============\n"
    print @player_board.render(true)
    sub_chooser
  end
  
  def sub_chooser
    puts "Enter the squares for the Submarine (2 spaces): example: A2 A3"
    cords = []
    until @player_board.valid_placement?(@p_submarine, cords)
      ans = gets.chomp
      cords = ans.upcase.split(" ")
      if @player_board.valid_placement?(@p_submarine, cords) == false
        cords = []
        p  "Invalid placement, try again."
      end
    end
    @player_board.place(@p_submarine, cords)
    puts "==============PLAYER BOARD==============\n"
    print @player_board.render(true)
          
    turn       
  end
  
  def turn
    # require 'pry'; binding.pry
    until @p_cruiser.sunk? == true && @p_submarine.sunk? == true ||
      @com_cruiser.sunk? == true && @com_submarine.sunk? == true
      
      #need to call sunk differently
      coordinate = @player_board.cells.to_a.sample
      coordinate.last.fire_upon
      puts "My shot on #{coordinate.first} was a #{shot_feedback(coordinate)}!"
      puts "==============PLAYER BOARD==============\n"
      print @player_board.render(true)
      
      puts "Enter the coordinate for your shot:\n"
      coordinate = nil
      until @computer_board.valid_coordinate?(coordinate)
        ans = gets.chomp
        coordinate = ans.upcase
        if @computer_board.valid_coordinate?(coordinate) == false
          p  "Invalid coordinate, try again."     
          #display results of hits and misses every turn
        end
        @computer_board.cells[coordinate.last].fire_upon
        puts "Your shot on #{coordinate.first} was a #{shot_feedback(coordinate)}!"
        
        puts  "=============COMPUTER BOARD=============\n"
        print @computer_board.render(true)
        # require 'pry'; binding.pry
      end
    end
    end_game
  end


  def end_game
    if @p_cruiser.sunk? == true && @p_submarine.sunk? == true 
    puts "I WON!"
    main_menu
    elsif @com_cruiser.sunk? == true && @com_submarine.sunk? == true
    puts "YOU WON!"
    main_menu
    end
  end

  def shot_feedback(coordinate)
    if coordinate.last.fired_upon? == true && coordinate.empty? == true
      return "close ish"
    elsif coordinate.last.fired_upon? == true && coordinate.empty? == false && coordinate.last.ship.sunk? == true
      return "You sunk me"
    elsif coordinate.last.fired_upon? == true && coordinate.empty? == false
       "Nice shot"
    end
  end
end