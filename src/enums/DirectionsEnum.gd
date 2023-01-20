enum DIRECTIONS {
	LEFT,
	RIGHT,
	UP,
	DOWN
}

static func get_directions() -> Array:
	return [
		DIRECTIONS.UP,
		DIRECTIONS.DOWN,
		DIRECTIONS.LEFT,
		DIRECTIONS.RIGHT
	]

static func get_opposite(direction):
	match direction:
		DIRECTIONS.UP:
			return DIRECTIONS.DOWN
		DIRECTIONS.DOWN:
			return DIRECTIONS.UP
		DIRECTIONS.RIGHT:
			return DIRECTIONS.LEFT
		DIRECTIONS.LEFT:
			return DIRECTIONS.RIGHT
		_: push_error("Unrecognized direction in get_opposite function")
	
static func are_opposite(direction_A, direction_B):
	return direction_A == get_opposite(direction_B)

static func are_diagonal(direction_A, direction_B):
	if direction_A == DIRECTIONS.UP || direction_A == DIRECTIONS.DOWN:
		return direction_B == DIRECTIONS.RIGHT || direction_B == DIRECTIONS.LEFT
	elif direction_A == DIRECTIONS.RIGHT || direction_A == DIRECTIONS.LEFT:
		return direction_B == DIRECTIONS.UP || direction_B == DIRECTIONS.DOWN
	else:
		return false
