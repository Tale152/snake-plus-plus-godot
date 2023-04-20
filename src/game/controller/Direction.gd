enum DirectionEnum {
	UP,
	RIGHT,
	DOWN,
	LEFT
}

class_name Direction
# intended to be used and Enum that can be exported easily

static func UP() -> int: return DirectionEnum.UP
static func RIGHT() -> int: return DirectionEnum.RIGHT
static func DOWN() -> int: return DirectionEnum.DOWN
static func LEFT() -> int: return DirectionEnum.LEFT

static func get_directions() -> Array:
	return [DirectionEnum.UP, DirectionEnum.RIGHT, DirectionEnum.DOWN, DirectionEnum.LEFT]

static func get_opposite(dir: int) -> int:
	match dir:
		DirectionEnum.UP: return DirectionEnum.DOWN
		DirectionEnum.RIGHT: return DirectionEnum.LEFT
		DirectionEnum.DOWN: return DirectionEnum.UP
		DirectionEnum.LEFT: return DirectionEnum.RIGHT
	return -1

static func are_opposite(dir1: int, dir2: int) -> bool:
	match dir1:
		DirectionEnum.UP: return dir2 == DirectionEnum.DOWN
		DirectionEnum.RIGHT: return dir2 == DirectionEnum.LEFT
		DirectionEnum.DOWN: return dir2 == DirectionEnum.UP
		DirectionEnum.LEFT: return dir2 == DirectionEnum.RIGHT
	return false

static func get_sides(direction: int) -> Array:
	match direction:
		DirectionEnum.UP: return [DirectionEnum.LEFT, DirectionEnum.RIGHT]
		DirectionEnum.DOWN: return [DirectionEnum.LEFT, DirectionEnum.RIGHT]
		DirectionEnum.LEFT: return [DirectionEnum.UP, DirectionEnum.DOWN]
		DirectionEnum.RIGHT: return [DirectionEnum.UP, DirectionEnum.DOWN]
	return []
