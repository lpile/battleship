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

  def test_it_is_not_fired_upon_by_default
    refute @cell.fired_upon?
  end

  def test_fire_upon_reduces_a_placed_ships_health
    @cell.place_ship(@ship)
    @cell.fire_upon

    assert_equal 2, @cell.ship.health
  end

  def test_fire_upon_updates_fired_upon_to_true
    @cell.fire_upon
    assert @cell.fired_upon?
  end

  def test_it_displays_a_dot_if_it_has_not_been_fired_upon
    @cell.place_ship(@ship)
    assert_equal ".", @cell.render
  end

  def test_it_displays_an_m_if_it_has_been_fired_upon_with_no_ship
    @cell.fire_upon
    assert_equal "M", @cell.render
  end

  def test_it_displays_a_dot_after_placing_a_ship
    @cell.place_ship(@ship)
    assert_equal ".", @cell.render
  end

  def test_it_displays_an_s_if_it_has_a_ship_with_render_true_argument
    @cell.place_ship(@ship)
    assert_equal "S", @cell.render(true)
  end

  def test_it_displays_an_h_if_it_has_a_ship_and_is_fired_upon
    @cell.place_ship(@ship)
    @cell.fire_upon
    assert_equal "H", @cell.render
  end
end
