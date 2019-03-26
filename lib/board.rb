class Board

	attr_reader :cells

	def initialize(num)
	   @cells = {}
     create_cells(num)
		 @size = num
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
		letters = coordinates.map {|i| i[0]}
		numbers = coordinates.map {|i| i[1]}

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
		display = "  "
		@size.times do |width|
			if width < 8
				display += " #{width + 1} "
			else
				display += " #{width + 1}"
			end
		end
		display += "\n"
		@size.times do |width|
			display += "#{(65 + width).chr} "
			@size.times do |cell|
				display += " #{@cells["#{(65 + width).chr}#{cell + 1}"].render(boolean)} "
			end
			display += "\n"
		end
		display
	end

end
