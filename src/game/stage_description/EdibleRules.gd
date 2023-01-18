class_name EdibleRules extends Reference

var _type: String
var _spawn_locations: Array
var _spawn_probability: float
var _life_span: float
var _max_instances: int
var _on_head_collision_strategy

func _init(
	type: String,
	spawn_locations: Array,
	spawn_probability: float,
	life_spawn: float,
	max_instances: int,
	on_head_collision_strategy
):
	_type = type
	_spawn_locations = spawn_locations
	_spawn_probability = spawn_probability
	_life_span = life_spawn
	_max_instances = max_instances
	_on_head_collision_strategy = on_head_collision_strategy

func get_type() -> String:
	return _type

func get_spawn_locations() -> Array:
	return _spawn_locations

func get_spawn_probability() -> float:
	return _spawn_probability

func get_life_span() -> float:
	return _life_span

func get_max_instances() -> int:
	return _max_instances

func get_on_head_collision_strategy():
	return _on_head_collision_strategy
