class Board

	attr_reader :cells

	def initialize(num)
	   @cells = {}
     create_cells(num)
	end

	def create_cells(num)
		("A"..(64 + num).chr).each do |letter|
			(1..num).each do |number|
				index = "#{letter}#{number}"
				@cells[index] = Cell.new(index)
			end
		end
	end

	def valid_coordinate?(cell)
    @cells.include?(cell)
	end

	def valid_placement?(ship, coordinates)
		if ship.length == coordinates.length
			if consecutive_coordinates?(coordinates)
				if overlap_check?(coordinates)
					true
				end
			end
		else
			false
		end
	end

	def consecutive_coordinates?(coordinates)
		letters = []
		numbers = []
		coordinates.each do |cell|
			letters << cell[0]
			numbers << cell[1]
		end

		if letters.uniq.length == 1
		  numbers.each_cons(2).all? {|x,y| y.ord == x.ord + 1}
		elsif numbers.uniq.length == 1
		  letters.each_cons(2).all? {|x,y| y.ord == x.ord + 1}
		else
		  false
		end
	end

	def overlap_check?(coordinates)
		coordinates.each do |coordinate|
			unless @cells[coordinate].empty?
				return false
			end
		end
	end

	def place(ship, coordinates)
		coordinates.each do |coordinate|
			cell = @cells[coordinate]
			cell.place_ship(ship)
		end
	end

	def render(boolean = false)
		# board_size = @cells.length
"  1 2 3 4 \nA #{@cells["A1"].render(boolean)} #{@cells["A2"].render(boolean)} #{@cells["A3"].render(boolean)} #{@cells["A4"].render(boolean)} \nB #{@cells["B1"].render(boolean)} #{@cells["B2"].render(boolean)} #{@cells["B3"].render(boolean)} #{@cells["B4"].render(boolean)} \nC #{@cells["C1"].render(boolean)} #{@cells["C2"].render(boolean)} #{@cells["C3"].render(boolean)} #{@cells["C4"].render(boolean)} \nD #{@cells["D1"].render(boolean)} #{@cells["D2"].render(boolean)} #{@cells["D3"].render(boolean)} #{@cells["D4"].render(boolean)} \n"
	end

end
