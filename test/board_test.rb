require 'minitest/autorun'
require 'minitest/pride'
require './lib/cell'
require './lib/ship'
require './lib/board'
require 'pry'

class BoardTest < Minitest::Test
  def setup
    @board = Board.new(4)
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)
  end

  def test_if_board_was_created
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

  def test_ship_length_for_valid_placement
    refute @board.valid_placement?(@cruiser, ["A1", "A2"])
    refute @board.valid_placement?(@submarine, ["A2", "A3", "A4"])
    assert @board.valid_placement?(@cruiser, ["A2", "A3", "A4"])
    assert @board.valid_placement?(@submarine, ["A1", "A2"])
  end

  def test_if_coordinates_are_consecutive_horizontal_on_board
    refute @board.valid_placement?(@cruiser, ["A1", "A2", "A4"])
    refute @board.valid_placement?(@submarine, ["A1", "A3"])
    refute @board.valid_placement?(@cruiser, ["A3", "A2", "A1"])
    refute @board.valid_placement?(@submarine, ["B2", "B1"])
    assert @board.valid_placement?(@cruiser, ["D2", "D3", "D4"])
    assert @board.valid_placement?(@submarine, ["A1", "A2"])
  end

  def test_if_coordinates_are_diagonal_on_board
    refute @board.valid_placement?(@cruiser, ["A1", "B2", "C3"])
    refute @board.valid_placement?(@submarine, ["C2", "D3"])
  end

  def test_if_coordinates_are_consecutive_vertical_on_board
    refute @board.valid_placement?(@cruiser, ["A1", "B1", "D1"])
    refute @board.valid_placement?(@submarine, ["A1", "C1"])
    refute @board.valid_placement?(@cruiser, ["D4", "C4", "B4"])
    refute @board.valid_placement?(@submarine, ["C1", "B1"])

    assert @board.valid_placement?(@cruiser, ["A1", "B1", "C1"])
    assert @board.valid_placement?(@submarine, ["C1", "D1"])
  end

  def test_it_can_place_a_ship_on_the_board
    @board.place(@cruiser, ["A1", "A2", "A3"])
    second_cell = @board.cells["A2"]
    third_cell = @board.cells["A3"]

    assert third_cell.ship == second_cell.ship
  end

  def test_it_cannot_overlap_placements_of_ships
    @board.place(@cruiser, ["A1", "A2", "A3"])
    @board.place(@submarine, ["C4", "D4"])

    refute @board.valid_placement?(@submarine, ["A1", "A2"])
    refute @board.valid_placement?(@cruiser, ["A4", "B4", "C4"])
  end

  def test_if_board_can_render
    @board.place(@cruiser, ["A1", "A2", "A3"])

    assert_equal "  1 2 3 4 \nA", @board.render
  end
end
