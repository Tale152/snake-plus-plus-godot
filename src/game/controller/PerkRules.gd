class_name PerkRules extends Reference

var _type: int
var _spawn_locations: Array
var _spawn_probability: float
var _lifespan: float
var _max_instances: int
var _collision_strategy: CollisionStrategy

func _init(
	type: int,
	spawn_locations: Array,
	spawn_probability: float,
	lifespan: float,
	max_instances: int,
	collision_strategy: CollisionStrategy
):
	_type = type
	_spawn_locations = spawn_locations
	_spawn_probability = spawn_probability
	_lifespan = lifespan
	_max_instances = max_instances
	_collision_strategy = collision_strategy

func get_type() -> int:
	return _type

func get_spawn_locations() -> Array:
	return _spawn_locations

func get_spawn_probability() -> float:
	return _spawn_probability

func get_lifespan() -> float:
	return _lifespan

func get_max_instances() -> int:
	return _max_instances

func get_collision_strategy() -> CollisionStrategy:
	return _collision_strategy
