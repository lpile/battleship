require './lib/board'
require './lib/cell'
require './lib/ship'

class Computer
  attr_reader :board, :cruiser, :submarine

  def initialize(board_size)
    @board = Board.new(board_size)
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)
    computer_place(@cruiser)
    computer_place(@submarine)
  end

  def computer_place(ship)
    cells = @board.cells.keys
    all_combos = cells.combination(ship.length).to_a
    valid_coords = []
    all_combos.each do |combo|
      if @board.valid_placement?(ship, combo)
        valid_coords << combo
      end
    end
    @board.place(ship, valid_coords.sample)
  end

end
