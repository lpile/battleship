require 'minitest/autorun'
require 'minitest/pride'
require './lib/cell'
require './lib/ship'
require './lib/board'
require 'pry'

class BoardTest < Minitest::Test
  def setup
    @board = Board.new

  end

  def test_if_board_was_created
    @board.cells
    assert_instance_of Board, @board
    assert_equal 16, @board.cells.length
  end

  def test_if_coordinate_is_valid_on_board
    assert @board.valid_coordinate?("A1")
    assert @board.valid_coordinate?("D4")
    refute @board.valid_coordinate?("A5")
    refute @board.valid_coordinate?("E1")
    refute @board.valid_coordinate?("A22")
  end
end
