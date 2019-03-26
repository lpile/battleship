require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/computer'
submarine = Ship.new("Submarine", 2)
cruiser = Ship.new("Cruiser", 3)

puts "Welcome to BATTLESHIP"
puts "Enter p to play. Enter q to quit."
input = gets.chomp
while input != "p" || input != "q"
  if input == "p"
    puts "What size do you want your board to be?"
    board_size = gets.chomp.to_i
    ## Initialize Player and Computer Boards and variables
    player_board = Board.new(board_size)
    computer_player = Computer.new(board_size)
    computer_board = computer_player.board
    computer_cruiser = computer_player.cruiser
    computer_submarine = computer_player.submarine
    ##
    puts "I have laid out my ships on the grid."
    puts "You now need to lay out your two ships."
    puts "The Cruiser is three units long and the Submarine is two units long."
    puts player_board.render

    loop do
      puts "Where do you want to put your submarine?"
      print "Two coordinates:"
      sub_placement = gets.chomp.upcase
      if player_board.valid_placement?(submarine, sub_placement.split(" "))
        player_board.place(submarine, sub_placement.split(" "))
        break
      else
        puts "Those are invalid coordinates, please try again."
      end
    end
    puts player_board.render(true)
    loop do
      puts "Where do you want to put your cruiser?"
      print "Three coordinates:"
      cru_placement = gets.chomp.upcase
      if player_board.valid_placement?(cruiser, cru_placement.split(" "))
        player_board.place(cruiser, cru_placement.split(" "))
        break
      else
        puts "Those are invalid coordinates, please try again."
      end
    end
    puts player_board.render(true)
    ### Begin the Game
    player_guesses = []
    until submarine.health == 0 && cruiser.health == 0 || computer_submarine.health == 0 && computer_cruiser.health == 0
      puts "============COMPUTER BOARD============"
      puts computer_board.render(true)
      puts "============PLAYER BOARD============"
      puts player_board.render(true)
      loop do
        puts "Enter the coordinate for your shot:"
        shot = gets.chomp.upcase
        if player_guesses.include?(shot)
          puts "You have already fired on that cell, please try again."
        elsif computer_board.valid_coordinate?(shot)
          computer_board.cells[shot].fire_upon
          player_guesses << shot
          if computer_board.cells[shot].render == "M"
            response = "was a miss."
          elsif computer_board.cells[shot].render == "H"
            response = "was a hit."
          else
            response = "sunk a ship!"
          end
          puts "Your shot on #{shot} #{response}"
          computer_player.computer_guess(player_board)
          break
        else
          puts "Those are invalid coordinates, please try again."
        end
      end
    end
    if submarine.health == 0 && cruiser.health == 0
      puts "I won!"
    else
      puts "You won!"
    end
  elsif input == "q"
    puts "Goodbye."
    exit
  end
puts "Try again!"
puts "Enter p to play. Enter q to quit."
input = gets.chomp
end
