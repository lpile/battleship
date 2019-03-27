require './lib/board'
require './lib/cell'
require './lib/ship'

class Computer
  attr_reader :board, :cruiser, :submarine

  def initialize(board_size)
    @board = Board.new(board_size)
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)
    @possible_guesses = @board.cells.keys
    computer_place(@cruiser)
    computer_place(@submarine)
  end

  def computer_place(ship)
    cells = @board.cells.keys
    valid_coords = []
    all_combos = cells.combination(ship.length).to_a
    all_combos.each do |combo|
      if @board.valid_placement?(ship, combo)
        valid_coords << combo
      end
    end
    @board.place(ship, valid_coords.sample)
  end

  def computer_guess(player_board)
      shot = @possible_guesses.sample
      player_board.cells[shot].fire_upon
      @possible_guesses.delete(shot)
      if player_board.cells[shot].render == "M"
        response = "was a miss."
      elsif player_board.cells[shot].render == "H"
        response = "was a hit."
      else
        response = "sunk a ship!"
      end
      puts "My shot on #{shot} #{response}"
  end

end
