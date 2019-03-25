require './lib/board'
require './lib/cell'
require './lib/ship'

class Computer
  attr_reader :board, :cruiser, :submarine

  def initialize(board_size)
    @board = Board.new(board_size)
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)

  end


end
