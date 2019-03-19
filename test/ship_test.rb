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
    assert_equal "Cruiser", @cruiser.name
    assert_equal 3, @cruiser.length
    assert_equal 3, @cruiser.health
  end

  def test_ship_has_name
    assert_equal "Cruiser", @cruiser.name
  end

  def test_ship_has_length
    assert_equal 3, @cruiser.length
  end

  def test_ship_has_health
    assert_equal 3, @cruiser.health
  end

end
