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
