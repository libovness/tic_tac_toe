class Player

	attr_accessor :name, :char, :is_turn

	def initialize 
		@player
	end 

	# Only accept words as player names
	def name_is_valid?(name)
		/\w/.match(name) ? true : false
	end

end