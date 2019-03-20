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
  end
end
