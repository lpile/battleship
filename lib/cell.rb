class Cell
  attr_reader :coordinate, :ship

  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil
    @empty = true
    @fire_upon = false
  end

  def empty?
    @empty
  end

  def place_ship(ship)
    @ship = ship
    @empty = false
  end

  def fired_upon?
    @fire_upon
  end

  def fire_upon
    @fire_upon = true
    if @ship != nil
      @ship.hit
    end
  end

  def render(boolean = false)
    if boolean == true
      "S"
    elsif @fire_upon == false
      "."
    elsif @empty == true && @fire_upon == true
      "M"
    elsif @ship.sunk?
      "X"
    elsif @empty == false && @fire_upon == true
      "H"
    end
  end

end
