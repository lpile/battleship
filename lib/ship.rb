class Ship
  attr_reader :name, :health, :length

  def initialize(name, health)
    @name = name
    @health = health
    @length = health
    @sunk = false
  end

  def sunk?
    @sunk
  end

  def hit
    @health -= 1
    @sunk = true ? @health == 0 : false
  end

end
