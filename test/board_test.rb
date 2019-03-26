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


  def test_it_can_render_with_no_ships
    assert_equal "   1  2  3  4 \nA  .  .  .  . \nB  .  .  .  . \nC  .  .  .  . \nD  .  .  .  . \n", @board.render(true)
  end

  def test_it_can_render_with_a_ship
    @board.place(@cruiser, ["A1", "A2", "A3"])

    assert_equal "   1  2  3  4 \nA  .  .  .  . \nB  .  .  .  . \nC  .  .  .  . \nD  .  .  .  . \n", @board.render
    assert_equal "   1  2  3  4 \nA  S  S  S  . \nB  .  .  .  . \nC  .  .  .  . \nD  .  .  .  . \n", @board.render(true)
  end

  def test_it_can_render_a_six_wide_board
    board = Board.new(6)
    board.place(@cruiser, ["A4", "A5", "A6"])
    board.place(@submarine, ["C4", "D4"])

    assert_equal "   1  2  3  4  5  6 \nA  .  .  .  .  .  . \nB  .  .  .  .  .  . \nC  .  .  .  .  .  . \nD  .  .  .  .  .  . \nE  .  .  .  .  .  . \nF  .  .  .  .  .  . \n", board.render
    assert_equal "   1  2  3  4  5  6 \nA  .  .  .  S  S  S \nB  .  .  .  .  .  . \nC  .  .  .  S  .  . \nD  .  .  .  S  .  . \nE  .  .  .  .  .  . \nF  .  .  .  .  .  . \n", board.render(true)
  end

  def test_it_can_render_a_twentysix_wide_board
    board = Board.new(26)
    board.place(@cruiser, ["R15", "R16", "R17"])
    board.place(@submarine, ["X4", "Y4"])

    assert_equal "   1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26\nA  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  . \nB  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  . \nC  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  . \nD  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  . \nE  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  . \nF  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  . \nG  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  . \nH  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  . \nI  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  . \nJ  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  . \nK  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  . \nL  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  . \nM  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  . \nN  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  . \nO  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  . \nP  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  . \nQ  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  . \nR  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  . \nS  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  . \nT  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  . \nU  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  . \nV  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  . \nW  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  . \nX  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  . \nY  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  . \nZ  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  . \n", board.render
    assert_equal "   1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26\nA  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  . \nB  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  . \nC  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  . \nD  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  . \nE  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  . \nF  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  . \nG  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  . \nH  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  . \nI  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  . \nJ  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  . \nK  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  . \nL  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  . \nM  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  . \nN  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  . \nO  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  . \nP  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  . \nQ  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  . \nR  .  .  .  .  .  .  .  .  .  .  .  .  .  .  S  S  S  .  .  .  .  .  .  .  .  . \nS  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  . \nT  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  . \nU  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  . \nV  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  . \nW  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  . \nX  .  .  .  S  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  . \nY  .  .  .  S  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  . \nZ  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  . \n", board.render(true)
  end

  def test_it_can_play_and_render_with_a_ship
    @board.place(@cruiser, ["A1", "A2", "A3"])
    guess_1 = @board.cells["A4"].fire_upon
    guess_2 = @board.cells["A3"].fire_upon
    guess_3 = @board.cells["A2"].fire_upon

    assert_equal "   1  2  3  4 \nA  .  H  H  M \nB  .  .  .  . \nC  .  .  .  . \nD  .  .  .  . \n", @board.render

    guess_4 = @board.cells["A1"].fire_upon

    assert_equal "   1  2  3  4 \nA  X  X  X  M \nB  .  .  .  . \nC  .  .  .  . \nD  .  .  .  . \n", @board.render
  end
end
