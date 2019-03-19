require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require 'pry'

class ShipTest < Minitest::Test
  # set up variables use for test
  def setup
    @cruiser = Ship.new("Cruiser", 3)
  end

  # test Ship class initialize
  def test_it_exists
    assert_instance_of Ship, @cruiser
  end

  # test if ship has attributes
  def test_ship_has_attributes
    assert_equal "Cruiser", @cruiser.name
    assert_equal 3, @cruiser.length
    assert_equal 3, @cruiser.health
  end

  # test if the ship has been sunk
  def test_if_ship_has_sunk
    refute @cruiser.sunk?
  end

  # test if the ship has been hit
  def test_if_ship_has_been_hit_once
    skip
    @cruiser.hit
    assert_equal 2, @cruiser.health
    refute @cruiser.sunk?
  end

  # test if the ship has been hit twice
  def test_if_ship_has_been_hit_twice
    skip
    @cruiser.hit
    @cruiser.hit
    assert_equal 1, @cruiser.health
    refute @cruiser.sunk?
  end

  # test if the ship has been hit thrice
  def test_if_ship_has_been_hit_thrice
    skip
    @cruiser.hit
    @cruiser.hit
    @cruiser.hit
    assert_equal 0, @cruiser.health
  end

  # test if the ship has sunk with no health
  def test_if_ship_is_sunk_with_no_health
    skip
    @cruiser.hit
    @cruiser.hit
    @cruiser.hit
    assert @cruiser.sunk?
  end
end
