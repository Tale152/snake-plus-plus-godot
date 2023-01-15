class_name StageDescription extends Reference

var _size: FieldSize
var _snake_spawn_point: ImmutablePoint
var _snake_initial_direction: int

func _init(
	size: FieldSize,
	snake_spawn_point: ImmutablePoint,
	snake_initial_direction: int
	):
	_size = size
	_snake_spawn_point = snake_spawn_point
	_snake_initial_direction = snake_initial_direction

func get_field_size() -> FieldSize:
	return _size

func get_snake_spawn_point() -> ImmutablePoint:
	return _snake_spawn_point

func get_snake_initial_direction() -> int:
	return _snake_initial_direction

# TODO add more fields
