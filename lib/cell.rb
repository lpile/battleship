class Cell
  attr_reader :coordinate, :ship

  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil
    @empty = true
    @fired_upon = false
  end

  def empty?
    @empty
  end

  def place_ship(ship)
    @ship = ship
    @empty = false
  end

  def fired_upon?
    @fired_upon
  end

  def fire_upon
    @fired_upon = true
    if @ship != nil
      @ship.hit
    end
  end

  def render(boolean = false)
    if boolean == true && @empty == false && @fired_upon == false
      "S"
    elsif @fired_upon == false
      "."
    elsif @empty == true && @fired_upon == true
      "M"
    elsif @ship.sunk?
      "X"
    elsif @empty == false && @fired_upon == true
      "H"
    end
  end

end
