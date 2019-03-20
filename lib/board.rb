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
		hor_arr = [
			["A1", "A2", "A3"],
			["A2", "A3", "A4"],
			["B1", "B2", "B3"],
			["B2", "B3", "B4"],
			["C1", "C2", "C3"],
			["C2", "C3", "C4"],
			["D1", "D2", "D3"],
			["D2", "D3", "D4"]
		]
		vert_arr = [
			["A1", "B1", "C1"],
			["B1", "C1", "D1"],
			["A2", "B2", "C2"],
			["B2", "C2", "D2"],
			["A3", "B3", "C3"],
			["B3", "C3", "D3"],
			["A4", "B4", "C4"],
			["B4", "C4", "D4"],
		]

		hor_arr.any? do |valid|
			valid == coordinates
		end

		vert_arr.any? do |valid|
			valid == coordinates
		end
	end
end
