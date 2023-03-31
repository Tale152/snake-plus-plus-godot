class_name GameController extends Reference

var _coordinates_instances: Array = []
var _snake_starting_coordinates: Coordinates
var _snake_initial_direction: int
var _walls_coordinates: Array = []

var _wall_factory: WallFactory = WallFactory.new()
var _snake_body_part_factory: SnakeBodyPartFactory = SnakeBodyPartFactory.new()

func _init(parsed_stage: ParsedStage):
	for x in range(0, parsed_stage.get_field_size().get_height()):
		for y in range(0, parsed_stage.get_field_size().get_width()):
			_coordinates_instances.push_back(Coordinates.new(x, y))
	_snake_starting_coordinates = _coordinates_instances[parsed_stage.get_snake_spawn_point().get_x() + parsed_stage.get_snake_spawn_point().get_y()]
	_snake_initial_direction = parsed_stage.get_snake_initial_direction()
	for wp in parsed_stage.get_walls_points():
		_walls_coordinates.push_back(_coordinates_instances[wp.get_x() + wp.get_y()])
		
func restart() -> void:
	var head: SnakeBodyPartTODO = _snake_body_part_factory.create_new(
		_snake_starting_coordinates, -1, -1
	)
	var walls: Array = []
	for w in _walls_coordinates:
		walls.push_back(_wall_factory.create_new(
			_coordinates_instances[w.get_x() + w.get_y()]
		))
