class Properties extends Reference:
	var current_length
	var potential_length
	var current_direction
	var can_input_direction
	
	func _init(initial_direction):
		current_length = 1
		potential_length = 1
		current_direction = initial_direction
