class_name DifficultySettings extends Reference

var _effects_lifespan_seconds: float
var _base_delta_seconds: float
var _speedup_factor: float

func _init(
	effects_lifespan_seconds: float,
	base_delta_seconds: float,
	speedup_factor: float
):
	_effects_lifespan_seconds = effects_lifespan_seconds
	_base_delta_seconds = base_delta_seconds
	_speedup_factor = speedup_factor

func get_effects_lifespan_seconds() -> float:
	return _effects_lifespan_seconds

func get_base_delta_seconds() -> float:
	return _base_delta_seconds

func get_speedup_factor() -> float:
	return _speedup_factor
