class_name StageDescription extends Reference

var _size: FieldSize
var _snake_spawn_point: ImmutablePoint

func _init(size: FieldSize, snake_spawn_point: ImmutablePoint):
	_size = size
	_snake_spawn_point = snake_spawn_point

func get_field_size() -> FieldSize:
	return _size

func get_snake_spawn_point() -> ImmutablePoint:
	return _snake_spawn_point

# TODO add more fields
