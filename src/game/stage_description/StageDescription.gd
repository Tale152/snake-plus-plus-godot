class_name StageDescription extends Reference

var _size: FieldSize
var _snake_spawn_point: ImmutablePoint
var _snake_initial_direction: int
var _snake_base_delta_seconds: float
var _snake_speedup_factor: float
var _instantaneous_edible_rules: Array
var _walls_points: Array

func _init(
	size: FieldSize,
	snake_spawn_point: ImmutablePoint,
	snake_initial_direction: int,
	snake_base_delta_seconds: float,
	snake_speedup_factor: float,
	instantaneous_edible_rules: Array,
	walls_points: Array
):
	_size = size
	_snake_spawn_point = snake_spawn_point
	_snake_initial_direction = snake_initial_direction
	_snake_base_delta_seconds = snake_base_delta_seconds
	_snake_speedup_factor = snake_speedup_factor
	_instantaneous_edible_rules = instantaneous_edible_rules
	_walls_points = walls_points

func get_field_size() -> FieldSize:
	return _size

func get_snake_spawn_point() -> ImmutablePoint:
	return _snake_spawn_point

func get_snake_initial_direction() -> int:
	return _snake_initial_direction

func get_snake_base_delta_seconds() -> float:
	return _snake_base_delta_seconds

func get_snake_speedup_factor() -> float:
	return _snake_speedup_factor

func get_instantaneous_edible_rules() -> Array:
	return _instantaneous_edible_rules

func get_walls_points() -> Array:
	return _walls_points
