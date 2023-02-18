class_name EquippedEffectTimer extends Reference

var _effect_type: String
var _elapsed_time: float
var _total_time: float

func _init(effect_type: String, elapsed_time: float, total_time: float):
	_effect_type = effect_type
	_elapsed_time = elapsed_time
	_total_time = total_time

func get_effect_type() -> String:
	return _effect_type

func get_elapsed_time() -> float:
	return _elapsed_time

func get_total_time() -> float:
	return _total_time