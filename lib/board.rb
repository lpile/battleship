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
			###########################################
			# horizontal test
			@hor_arr = []
	    @all_cells.each_cons(3).map do |x,y,z|
				if x.ord == y.ord && y.ord == z.ord
					@hor_arr << [x, y, z]
				end
			end
			###########################################
			# vertical test
			@vert_arr = []
			@all_cells.each_cons(9).map do |a,b,c,d,e,f,g,h,i|
			  if a[1].ord == e[1].ord && e[1].ord == i[1].ord
			    @vert_arr << [a, e, i]
			  end
			end
			###########################################
			@hor_arr.any? {|valid| valid == coordinates} || @vert_arr.any? {|valid| valid == coordinates}
		elsif ship.length == 2
			###########################################
			# horizontal test
			@hor_arr = []
	    @all_cells.each_cons(2).map do |x,y|
				if x.ord == y.ord
					@hor_arr << [x, y]
				end
			end
			###########################################
			# vertical test
			@vert_arr = []
			@all_cells.each_cons(5).map do |a,b,c,d,e|
			  if a[1].ord == e[1].ord
			    @vert_arr << [a, e]
			  end
			end
			###########################################
			@hor_arr.any? {|valid| valid == coordinates} || @vert_arr.any? {|valid| valid == coordinates}
		else
			raise ArgumentError.new("You messed up!")
		end
	end


end
