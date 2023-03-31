class_name GameController extends Reference

var _coordinates_instances: Array = []
var _snake_starting_coordinates: Coordinates
var _snake_initial_direction: int

func _init(parsed_stage: ParsedStage):
	for x in range(0, parsed_stage.get_field_size().get_height()):
		for y in range(0, parsed_stage.get_field_size().get_width()):
			_coordinates_instances.push_back(Coordinates.new(x, y))
	_snake_starting_coordinates = _coordinates_instances[parsed_stage.get_snake_spawn_point().get_x() + parsed_stage.get_snake_spawn_point().get_y()]
	_snake_initial_direction = parsed_stage.get_snake_initial_direction()
