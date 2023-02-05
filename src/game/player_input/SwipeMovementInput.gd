class_name SwipeMovementInput extends Reference

const SWIPE_CONTROLS_SENSITIVITY = 5

static func get_input_direction(event: InputEventScreenDrag) -> int:
	var swipe = event.relative
	if swipe.y < -SWIPE_CONTROLS_SENSITIVITY: return Directions.get_up()
	elif swipe.y > SWIPE_CONTROLS_SENSITIVITY: return Directions.get_down()
	elif swipe.x < -SWIPE_CONTROLS_SENSITIVITY: return Directions.get_left()
	elif swipe.x > SWIPE_CONTROLS_SENSITIVITY: return Directions.get_right()
	else: return -1
