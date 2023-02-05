class_name KeyMovementInput extends Reference

const _ACTION_MOVE_RIGHT: String = "move_right"
const _ACTION_MOVE_LEFT: String = "move_left"
const _ACTION_MOVE_UP: String = "move_up"
const _ACTION_MOVE_DOWN: String = "move_down"

static func get_input_direction() -> int:
	if Input.is_action_pressed(_ACTION_MOVE_UP): return Directions.get_up()
	elif Input.is_action_pressed(_ACTION_MOVE_DOWN): return Directions.get_down()
	elif Input.is_action_pressed(_ACTION_MOVE_LEFT): return Directions.get_left()
	elif Input.is_action_pressed(_ACTION_MOVE_RIGHT): return Directions.get_right()
	else: return -1
