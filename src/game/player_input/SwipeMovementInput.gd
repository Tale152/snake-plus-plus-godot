class_name SwipeMovementInput extends Reference

const SWIPE_CONTROLS_SENSITIVITY = 20

static func get_input_direction(event: InputEventScreenDrag) -> int:
	var swipe = event.relative
	var abs_x = abs(swipe.x)
	var abs_y = abs(swipe.y)
	if abs_y > abs_x:
		if abs_y > SWIPE_CONTROLS_SENSITIVITY:
			return Directions.get_up() if swipe.y < 0 else Directions.get_down()
	else:
		if abs_x > SWIPE_CONTROLS_SENSITIVITY:
			return Directions.get_left() if swipe.x < 0 else Directions.get_right()
	return -1
