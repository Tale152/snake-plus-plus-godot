class_name GameDirectionInputHandler extends Reference

const _NOT_ASSIGNED_DIRECTION: int = -1
const _NEXT_NEXT_DIRECTION_MOVEMENT_DELTA_TRESHOLD: float = 0.66
const _NEXT_NEXT_NEXT_DIRECTION_MOVEMENT_DELTA_TRESHOLD: float = 0.85

var _next_direction: int = _NOT_ASSIGNED_DIRECTION
var _next_next_direction: int = _NOT_ASSIGNED_DIRECTION
var _next_next_next_direction: int = _NOT_ASSIGNED_DIRECTION

func submit_input(
	current_direction: int,
	input_direction: int,
	movement_elapsed_seconds: float,
	current_snake_delta_seconds: float
) -> bool:
	if _is_direction_not_assigned(_next_direction):
		if _compatible_movement(current_direction, input_direction):
			_next_direction = input_direction
			return true
	elif _is_direction_not_assigned(_next_next_direction):
		if (
			_compatible_movement(_next_direction, input_direction) &&
			_can_register_next_next(movement_elapsed_seconds, current_snake_delta_seconds)
		):
			_next_next_direction = input_direction
			return true
	elif _is_direction_not_assigned(_next_next_next_direction):
		if (
			_compatible_movement(_next_next_direction, input_direction) &&
			_can_register_next_next_next(movement_elapsed_seconds, current_snake_delta_seconds)
		):
			_next_next_next_direction = input_direction
			return true
	return false

func get_next_direction() -> int:
	if _is_direction_not_assigned(_next_direction):
		return _NOT_ASSIGNED_DIRECTION
	var result = _next_direction
	_next_direction = _next_next_direction
	_next_next_direction = _next_next_next_direction
	_next_next_next_direction = _NOT_ASSIGNED_DIRECTION
	return result

func _is_direction_not_assigned(input_direction: int) -> bool:
	return input_direction == _NOT_ASSIGNED_DIRECTION

func _compatible_movement(
	current_direction: int,
	input_direction: int
) -> bool:
	return (
		current_direction != input_direction &&
		current_direction != Directions.get_opposite(input_direction)
	)

func _can_register_future_movement(
	movement_elapsed_seconds: float,
	current_snake_delta_seconds: float,
	treshold_delta_multiplier: float
) -> bool:
	return movement_elapsed_seconds > (current_snake_delta_seconds * treshold_delta_multiplier)

func _can_register_next_next(
	movement_elapsed_seconds: float,
	current_snake_delta_seconds: float
) -> bool:
	return _can_register_future_movement(
		movement_elapsed_seconds,
		current_snake_delta_seconds,
		_NEXT_NEXT_DIRECTION_MOVEMENT_DELTA_TRESHOLD
	)

func _can_register_next_next_next(
	movement_elapsed_seconds: float,
	current_snake_delta_seconds: float
) -> bool:
	return _can_register_future_movement(
		movement_elapsed_seconds,
		current_snake_delta_seconds,
		_NEXT_NEXT_NEXT_DIRECTION_MOVEMENT_DELTA_TRESHOLD
	)
