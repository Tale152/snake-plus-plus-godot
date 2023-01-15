class_name StageDescriptionBuilder extends Reference

const DIRECTIONS = preload("res://src/enums/DirectionsEnum.gd").DIRECTIONS

var _size: FieldSize = null
var _snake_spawn_point: ImmutablePoint = null
var _snake_initial_direction: int = -1

func set_field_size(size: FieldSize) -> StageDescriptionBuilder:
	_size = size
	return self

func set_snake_spawn_point(point: ImmutablePoint) -> StageDescriptionBuilder:
	_snake_spawn_point = point
	return self

func set_snake_initial_direction(direction: int) -> StageDescriptionBuilder:
	_snake_initial_direction = direction
	return self

func build() -> StageDescription:
	if _all_check_pass():
		return StageDescription.new(
			_size,
			_snake_spawn_point,
			_snake_initial_direction
		)
	else:
		return null

func _all_check_pass() -> bool:
	return (
		_is_field_size_valid()
		&& _is_snake_spawn_point_valid()
		&& _is_snake_initial_direction_valid()
	)
func _is_field_size_valid():
	return _size != null && _size.get_height() > 0 && _size.get_width() > 0

func _is_snake_spawn_point_valid():
	return (
		_snake_spawn_point != null
		&& _snake_spawn_point.get_x() >= 0
		&& _snake_spawn_point.get_x() < _size.get_width()
		&& _snake_spawn_point.get_y() >= 0
		&& _snake_spawn_point.get_y() < _size.get_height()
	)

func _is_snake_initial_direction_valid():
	return (
		_snake_initial_direction == DIRECTIONS.UP
		|| _snake_initial_direction == DIRECTIONS.DOWN
		|| _snake_initial_direction == DIRECTIONS.LEFT
		|| _snake_initial_direction == DIRECTIONS.RIGHT
	)
