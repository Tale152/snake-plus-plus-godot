enum DIRECTIONS_ENUM {
	LEFT,
	RIGHT,
	UP,
	DOWN
}

class_name Directions

static func get_up() -> int:
	return DIRECTIONS_ENUM.UP

static func get_down() -> int:
	return DIRECTIONS_ENUM.DOWN

static func get_left() -> int:
	return DIRECTIONS_ENUM.LEFT

static func get_right() -> int:
	return DIRECTIONS_ENUM.RIGHT

static func get_directions() -> Array:
	return [
		DIRECTIONS_ENUM.UP,
		DIRECTIONS_ENUM.DOWN,
		DIRECTIONS_ENUM.LEFT,
		DIRECTIONS_ENUM.RIGHT
	]

static func get_opposite(direction: int) -> int:
	match direction:
		DIRECTIONS_ENUM.UP:
			return DIRECTIONS_ENUM.DOWN
		DIRECTIONS_ENUM.DOWN:
			return DIRECTIONS_ENUM.UP
		DIRECTIONS_ENUM.RIGHT:
			return DIRECTIONS_ENUM.LEFT
		DIRECTIONS_ENUM.LEFT:
			return DIRECTIONS_ENUM.RIGHT
	return -1

static func are_opposite(direction_A, direction_B) -> bool:
	return direction_A == get_opposite(direction_B)

static func are_diagonal(direction_A, direction_B) -> bool:
	if direction_A == DIRECTIONS_ENUM.UP || direction_A == DIRECTIONS_ENUM.DOWN:
		return direction_B == DIRECTIONS_ENUM.RIGHT || direction_B == DIRECTIONS_ENUM.LEFT
	elif direction_A == DIRECTIONS_ENUM.RIGHT || direction_A == DIRECTIONS_ENUM.LEFT:
		return direction_B == DIRECTIONS_ENUM.UP || direction_B == DIRECTIONS_ENUM.DOWN
	else:
		return false
