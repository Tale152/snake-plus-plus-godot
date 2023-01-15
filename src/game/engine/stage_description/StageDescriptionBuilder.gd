class_name StageDescriptionBuilder extends Reference

var _size: FieldSize
var _snake_spawn_point: ImmutablePoint

func set_field_size(size: FieldSize) -> StageDescriptionBuilder:
	_size = size
	return self

func set_snake_spawn_point(point: ImmutablePoint) -> StageDescriptionBuilder:
	_snake_spawn_point = point
	return self

func build() -> StageDescription:
	if _is_field_size_valid() \
		&& _is_snake_spawn_point_valid():
		return StageDescription.new(_size, _snake_spawn_point)
	return null
	
func _is_field_size_valid():
	return _size != null && _size.get_height() > 0 && _size.get_width() > 0

func _is_snake_spawn_point_valid():
	return _snake_spawn_point != null \
		&& _snake_spawn_point.get_x() >= 0 \
		&& _snake_spawn_point.get_x() < _size.get_width() \
		&& _snake_spawn_point.get_y() >= 0 \
		&& _snake_spawn_point.get_y() < _size.get_height()
