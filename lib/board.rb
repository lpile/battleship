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

	# def cells
  #   ("A".."D").each do |letter|
  #     (1..4).each do |number|
  #       index = "#{letter}#{number}"
  #       @cells[index] = Cell.new(index)
  #     end
  #   end
  #   @cells
  # end

end
