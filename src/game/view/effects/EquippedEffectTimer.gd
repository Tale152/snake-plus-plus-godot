class_name EquippedEffectTimer extends Reference

var _effect_type: int
var _elapsed_time: float
var _total_time: float
var _percentage: int

func _init(effect_type: int, elapsed_time: float, total_time: float):
	_elapsed_time = elapsed_time
	_total_time = total_time
	_percentage = int(floor(100 - (elapsed_time * 100 / total_time)))

func get_effect_type() -> int:
	return _effect_type

func get_elapsed_time() -> float:
	return _elapsed_time

func get_total_time() -> float:
	return _total_time

func get_percentage() -> int:
	return _percentage
