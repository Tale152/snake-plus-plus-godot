class Placement extends Reference:
	var coordinates
	var next_direction
	var previous_direction
	
	func _init(cord, next_dir, previous_dir):
		coordinates = cord
		next_direction = next_dir
		previous_direction = previous_dir
