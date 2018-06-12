require './lib/board'
require './lib/player'
require 'io/console'

@board = Board.new
@p1 = Player.new
@p2 = Player.new
@current_player = @p1

# Press any key to continue
def continue_on                                                                                                                                                                                                             
  STDIN.getch                                                                                                              
  print "            \r"
end  

# Take turns
def turn
	@p1.is_turn = !@p1.is_turn
	@p2.is_turn = !@p2.is_turn
	@current_player = @p1.is_turn ? @p1 : @p2
end

# Setup the game
def setup 
	puts "Press any key to start"
	continue_on

	# Create Player 1
	puts "Player 1, what is your name?"
	@p1.name = gets.chomp
	@p1.char = 'X'
	@p1.is_turn = true
	validate_name(@p1)
	
	# Create Player 2
	puts "Player 2, what is your name?"
	@p2.name = gets.chomp
	@p2.char = 'O'
	@p2.is_turn = false
	validate_name(@p2)

	@board.display_dummy

	puts "As soon as you're ready to start #{@p1.name}, punch in the number of the box where you want to place your first move."
	play
end

# Interact with user if their username isn't valid
def validate_name(player)
	if player.name_is_valid?(player.name)
		puts "Cool! #{player.name}, you'll be the #{player.char}"
	else
		puts "Sorry, that is not a valid name. Try again"
		player.name = gets.chomp
		validate_name(player)
	end
end

# Determine if position is taken. If not, play the move.
def play
	move = gets.chomp.to_i
	if @board.move_is_valid?(move)
		proceed_with(move)
	else 
		puts "That spot is taken. Try again."
		play
	end
end

# Determine if game has been won or stalemated. If neither, continue.
def proceed_with(move)
	@board.update(move,@current_player.char)
	@board.display

	if @board.won?
		puts "🎉 Congratulations #{@current_player.name}! 🎉"
		@board = Board.new
		puts "Let's play a new game"
		@board.display_dummy
		turn
		puts "#{@current_player.name}, you get the first move in the new game."
		play
	elsif @board.over?
		puts "The game has ended in a tie. Let's start over."
		turn
		puts "#{@current_player.name}, your move."
		play
	else
		turn
		puts "#{@current_player.name}, punch in the number of the box where you want to place your move."
		play
	end
end

# Start and play the game
setup
play