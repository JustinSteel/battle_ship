require './lib/board'
require './lib/ship'
require './lib/cell'

class Game
  def initialize
    @player_board = Board.new
    @computer_board = Board.new
    @com_cruiser = Ship.new("Cruiser", 3)    
    @com_submarine = Ship.new("Submarine", 2)
    @p_cruiser = Ship.new("Cruiser", 3)    
    @p_submarine = Ship.new("Submarine", 2)
    main_menu
  end

  def main_menu"
    
    "

    puts "\n Welcome to BATTLESHIP \n\n"
    puts "Enter p to play. Enter q to quit. <p/q>:"
    ans = gets.chomp
    if ans == "p"
      start
    end
  end

  def start
    computer_place_ships(@com_submarine)
    computer_place_ships(@com_cruiser)
    computer_board_output
    puts "\nI put my ships on my board! Hurry up!\n"
    puts "You now need to lay out your two ships."
    puts "The Cruiser is three units long and the Submarine is two units long.\n\n"
    player_board_output
    cruiser_chooser
    sub_chooser
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

  def player_board_output
    puts "==============PLAYER BOARD==============\n"
    print @player_board.render(true)
  end

  def computer_board_output
    puts "=============COMPUTER BOARD=============\n"
    print @computer_board.render 
  end

  def cruiser_chooser
    puts "Enter the squares for the Cruiser (3 spaces):"
    puts "Example: A1 A2 A3" 
    cords = []
    until @player_board.place(@p_cruiser, cords)
      ans = gets.chomp
      cords = ans.upcase.split(" ")
      if @player_board.valid_placement?(@p_cruiser, cords) == false
        cords = []
        p  "Did you really think that would work... try again."
      end
    end
    @player_board.place(@p_cruiser, cords)
    player_board_output
  end
  
  def sub_chooser
    puts "Enter the squares for the Submarine (2 spaces):"
    puts "Example: A2 A3"
    cords = []
    until @player_board.valid_placement?(@p_submarine, cords)
      ans = gets.chomp
      cords = ans.upcase.split(" ")
      if @player_board.valid_placement?(@p_submarine, cords) == false
        cords = []
        p  "Did you really think that would work... try again."
      end
    end
    @player_board.place(@p_submarine, cords)
    player_board_output          
    turn       
  end
  
  def computer_feedback(coordinate)
    if coordinate.last.ship == nil
      puts "My shot on #{coordinate.first} was a miss!"
    elsif coordinate.last.ship == @p_submarine && @p_submarine.sunk? == true
      puts "OOPS I sank your sub.. HA!"
    elsif coordinate.last.ship == @p_cruiser && @p_cruiser.sunk? == true
      puts "OOPS I sank your cruiser.. HA!"
    elsif coordinate.last.ship != nil
      puts "My shot on #{coordinate.first} was a hit!"
    end
  end

  def player_feedback(coordinate)
    if @computer_board.cells[coordinate].ship == nil
      puts "Your shot on #{coordinate} was a miss!"
    elsif @computer_board.cells[coordinate].ship == @com_submarine && @com_submarine.sunk? == true
      puts "NOOO! You sunk my sub!"
    elsif @computer_board.cells[coordinate].ship == @com_cruiser && @com_cruiser.sunk? == true
      puts "NOOO! You sunk my cruiser!"
    elsif @computer_board.cells[coordinate].ship != nil
      puts "Your shot on #{coordinate} was a hit!"
    end
  end

  def computer_turn
    coordinate = @player_board.cells.to_a.sample        
    until coordinate.last.fired_upon? == false  
      coordinate = @player_board.cells.to_a.sample
    end
    coordinate.last.fire_upon
    computer_feedback(coordinate)
    player_board_output
    if @p_cruiser.sunk? == true && @p_submarine.sunk? == true 
      end_game
    end
  end

  def player_turn
    puts "Enter the coordinate for your shot:\n"
    coordinate = nil
    until @computer_board.valid_coordinate?(coordinate)
      ans = gets.chomp
      coordinate = ans.upcase
      if @computer_board.valid_coordinate?(coordinate) == false
        p  "Did you really think that would work... try again."     
      end
    end
    @computer_board.cells[coordinate].fire_upon
    player_feedback(coordinate)      
    computer_board_output
  end

  def turn
    until @p_cruiser.sunk? == true && @p_submarine.sunk? == true ||
      @com_cruiser.sunk? == true && @com_submarine.sunk? == true   
      computer_turn
      player_turn
    end
    end_game
  end

  def end_game
    if @p_cruiser.sunk? == true && @p_submarine.sunk? == true 
      puts "HAHAHA! I WON!"
    elsif @com_cruiser.sunk? == true && @com_submarine.sunk? == true
      puts "Don't get cocky but YOU WON!"
    end
    initialize
  end

end



#need to only allow shot once per cell
