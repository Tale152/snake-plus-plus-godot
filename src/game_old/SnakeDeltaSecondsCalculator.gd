class_name SnakeDeltaSecondsCalculator extends Reference

var _base_delta_seconds: float
var _speedup_factor: float
var _last_calculated_delta: float

func _init(base_delta_seconds: float, speedup_factor: float):
	_base_delta_seconds = base_delta_seconds
	_speedup_factor = speedup_factor
	_last_calculated_delta = calculate_current_delta_seconds(1, 1.0)

func calculate_current_delta_seconds(
	total_snake_length: int,
	speed_multiplier: float
) -> float:
	var delta_seconds = _base_delta_seconds
	for i in total_snake_length:
		delta_seconds *= _speedup_factor
	_last_calculated_delta = delta_seconds * speed_multiplier
	
	return _last_calculated_delta

func get_last_calculated_delta() -> float:
	return _last_calculated_delta
