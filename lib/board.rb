class Board

	attr_reader :cells

	def initialize
	   @cells = {}
     ("A".."D").each do |letter|
       (1..4).each do |number|
         index = "#{letter}#{number}"
         @cells[index] = Cell.new(index)
       end
     end
	end

	def valid_coordinate?(cell)
    @cells.include?(cell)
  end

  def valid_placement?(ship, coordinates)
    if ship.length != coordinates.length
      false
    end
    # check consecutive coords
    hor_arr = []
    @cells.each_key.each_cons(ship.length) do |cell|
      hor_arr << cell
    end
    hor_arr.any? do |index|
      index == coordinates
    end
    # check vertical coords
    # vert_arr = []
    # vert_arr = @cells.keys

    end






  end
