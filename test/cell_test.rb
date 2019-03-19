require 'minitest/autorun'
require 'minitest/pride'
require './lib/cell'
require './lib/ship'
class CellTest < Minitest::Test
  def setup
    @cell = Cell.new("B4")
    @ship = Ship.new("Cruiser", 3)
  end

  def test_it_exists
    assert_instance_of Cell, @cell
  end

  def test_it_has_a_coordinate
    assert_equal "B4", @cell.coordinate
  end

  def test_it_does_not_have_a_ship_by_default
    assert_nil @cell.ship
  end

  def test_it_is_empty_by_default
    assert @cell.empty?
  end

  def test_it_can_place_a_ship
    @cell.place_ship(@ship)
    assert_instance_of Ship, @cell.ship
  end

  def test_it_is_not_empty_after_placing_a_ship
    @cell.place_ship(@ship)
    refute @cell.empty?
  end
end
