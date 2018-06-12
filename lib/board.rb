class Board

	def initialize
		@board = Array.new(3) {Array.new(3," ")}
		@move_count = 0
		@played_positions = Array.new
	end

	def update(position,val)
		case position 
			when 1 then @board[0][0] = val
			when 2 then @board[0][1] = val
			when 3 then @board[0][2] = val
			when 4 then @board[1][0] = val
			when 5 then @board[1][1] = val
			when 6 then @board[1][2] = val
			when 7 then @board[2][0] = val
			when 8 then @board[2][1] = val
			when 9 then @board[2][2] = val													
		end
		@move_count = @move_count + 1
	end

	def display
		puts "\n"
		(0..2).each do |row|
			(0..2).each do |col|
				print " " + @board[row][col].to_s + " "
				print "|" unless col == 2
			end
			puts row == 2 ? "\n\n" : "\n-----------\n"
		end
	end

	def display_dummy
		dummy_board = Array.new(3) {Array.new(3)}
		puts "\n"
		puts " 1 | 2 | 3 "
		puts "-----------"
		puts " 4 | 5 | 6 "
		puts "-----------"
		puts " 7 | 8 | 9 "
		puts "\n"
	end

	def reset
		@board = Array.new(3) {Array.new(3," ")}
	end
		
	def won?
		@won = false
				
		unless @move_count < 5

			# test rows and cols
			(0..2).each do |i|
				@won = true if @board[i][0] == @board[i][1] && @board[i][0] == @board[i][2] && @board[i][0] != " " && @board[i][1] != " " && @board[i][2] != " "
				@won = true if @board[0][i] == @board[1][i] && @board[0][i] == @board[2][i] && @board[0][i] != " " && @board[1][i] != " " && @board[2][i] != " "
		    end

		    # check for diagonals
			unless @won == true && @board[1][1] == " "
			    @won = true if @board[0][0] == @board[1][1] && @board[0][0] == @board[2][2] 
			    @won = true if @board[0][2] == @board[1][1] && @board[0][2] == @board[2][0]
			end
			
		end		
		
		@won

	end

	def over?
		@over = true
		(0..2).each do |row|
			(0..2).each do |col|
				@over = false && break if @board[row][col] == " "
			end
		end
		@over
	end

	def move_is_valid?(position)
		if @played_positions.index(position)
			result = false
		else 
			@played_positions << position 
			result = true
		end
		result
	end

end