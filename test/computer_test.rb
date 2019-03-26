require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/board'
require './lib/cell'
require './lib/computer'
class ComputerTest < Minitest::Test
  def setup
    @computer = Computer.new(4)
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

  def test_it_will_place_ships_randomly
    # srand will set a predetermined value for .sample, which is used inside of Computer for placing ships
    srand 1234
    computer = Computer.new(4)

    assert_equal "  1 2 3 4 \nA . S . . \nB . S . . \nC . . . . \nD . S S S \n", computer.board.render(true)
  end

  def test_it_will_fire_on_ships_randomly
    # srand will set a predetermined value for .sample, which is used inside of Computer for firing on ships
    srand 1234
    player_board = Board.new(4)
    computer = Computer.new(4)

    computer.computer_guess(player_board)

    assert player_board.cells["B3"].fired_upon?
  end
end
