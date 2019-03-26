require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/board'
require './lib/cell'
require './lib/computer'
class ComputerTest < Minitest::Test
  def setup
    @board = Board.new(4)
    @computer = Computer.new(@board)
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)
  end

  def test_it_exists
    assert_instance_of Computer, @computer
  end

  def test_it_has_a_board
    assert_instance_of Board, @computer.board
  end

  def test_it_has_ships
    assert_instance_of Ship, @computer.cruiser
    assert_instance_of Ship, @computer.submarine
  end

end
