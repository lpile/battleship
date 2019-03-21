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

		 ###########
		 @all_cells = @cells.keys
	end

	def valid_coordinate?(cell)
    @cells.include?(cell)
	end

	def valid_placement?(ship, coordinates)
		if ship.length != coordinates.length
			false
		elsif ship.length == 3
			@hor_arr = []
	    @all_cells.each_cons(3).map do |x,y,z|
				if x.ord == y.ord && y.ord == z.ord
					@hor_arr << [x, y, z]
				end
			end
			@hor_arr.any? {|valid| valid == coordinates}
		elsif ship.length == 2
			@hor_arr = []
	    @all_cells.each_cons(2).map do |x,y|
				if x.ord == y.ord
					@hor_arr << [x, y]
				end
			end
			@hor_arr.any? {|valid| valid == coordinates}
		else
			raise ArgumentError.new("You messed up!")
		end
	end


end
