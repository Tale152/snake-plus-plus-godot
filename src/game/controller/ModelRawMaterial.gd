class_name ModelRawMaterial extends Reference

var _field_width: int
var _field_height: int
var _coordinates_instances: Array = []
var _snake_starting_coordinates: Coordinates
var _snake_initial_direction: int
var _walls_coordinates: Array = []

func _init(parsed_stage: ParsedStage):
	_field_width = parsed_stage.get_field_width()
	_field_height = parsed_stage.get_field_width()
	for x in range(0, parsed_stage.get_field_height()):
		for y in range(0, parsed_stage.get_field_width()):
			_coordinates_instances.push_back(Coordinates.new(x, y))
	_snake_starting_coordinates = _coordinates_instances[parsed_stage.get_snake_spawn_point().x + parsed_stage.get_snake_spawn_point().y]
	_snake_initial_direction = parsed_stage.get_snake_initial_direction()
	for wp in parsed_stage.get_walls_points():
		_walls_coordinates.push_back(_coordinates_instances[wp.x + wp.y])

func get_field_width() -> int:
	return _field_width

func get_field_height() -> int:
	return _field_height

func get_coordinates_instances() -> Array:
	return _coordinates_instances

func get_snake_starting_coordinates() -> Coordinates:
	return _snake_starting_coordinates

func get_snake_initial_direction() -> int:
	return _snake_initial_direction

func get_walls_coordinates() -> Array:
	return _walls_coordinates
