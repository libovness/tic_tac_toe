require './lib/board'
require './lib/player'
require 'io/console'

@board = Board.new
@p1 = Player.new
@p2 = Player.new
@current_player = @p1

def continue_on                                                                                                                                                                                                             
  STDIN.getch                                                                                                              
  print "            \r"
end  

def turn
	@p1.is_turn = !@p1.is_turn
	@p2.is_turn = !@p2.is_turn
	@current_player = @p1.is_turn ? @p1 : @p2
end

def setup 
	puts "Press any key to start"
	continue_on
	puts "Player 1, what is your name?"

	# Create Player 1
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

def validate_name(player)
	if player.name_is_valid?(player.name)
		puts "Cool! #{player.name}, you'll be the #{player.char}"
	else
		puts "Sorry, that is not a valid name. Try again"
		player.name = gets.chomp
		validate_name(player)
	end
end

def play
	move = gets.chomp.to_i
	if @board.is_valid?(move)
		proceed_with(move)
	else 
		puts "That spot is taken. Try again."
		play
	end
end

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
		puts "The game had ended in a tie. Let's start over."
		turn
		puts "#{@current_player.name}, your move."
		play
	else
		turn
		puts "#{@current_player.name}, punch in the number of the box where you want to place your move."
		play
	end
end


setup
play