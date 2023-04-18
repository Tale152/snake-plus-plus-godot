class_name PerkRules extends Reference

var _type: int
var _spawn_locations: Array
var _spawn_probability: float
var _lifespan: float
var _max_instances: int
var _collision_strategy: CollisionStrategy
var _can_spawn_strategy: FuncRef

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
	if _spawn_probability == 1.0:
		_can_spawn_strategy = funcref(self, "_can_spawn_light")
	else:
		_can_spawn_strategy = funcref(self, "_can_spawn_probability")

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

func _can_spawn_light(current_instances: int, _rng: RandomNumberGenerator) -> bool:
	return current_instances < _max_instances

func _can_spawn_probability(current_instances: int, rng: RandomNumberGenerator) -> bool:
	return current_instances < _max_instances && rng.randf() < _spawn_probability

func can_spawn(current_instances: int, rng: RandomNumberGenerator) -> bool:
	return _can_spawn_strategy.call_func(current_instances, rng)
