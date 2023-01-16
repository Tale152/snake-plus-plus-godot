class_name InstantaneousEdibleRules extends Reference

var _type: String
var _spawn_locations: Array
var _spawn_probability: float
var _life_span: float

func _init(
	type: String,
	spawn_locations: Array,
	spawn_probability: float,
	life_spawn: float
):
	_type = type
	_spawn_locations = spawn_locations
	_spawn_probability = spawn_probability
	_life_span = life_spawn

func get_type() -> String:
	return _type

func get_spawn_locations() -> Array:
	return _spawn_locations

func get_spawn_probability() -> float:
	return _spawn_probability

func get_life_span() -> float:
	return _life_span
