class_name GameController extends Reference

var _field_width: int
var _field_height: int
var _coordinates_instances: Array = []
var _snake_starting_coordinates: Coordinates
var _snake_initial_direction: int
var _walls_coordinates: Array = []

var _wall_factory: WallFactory = WallFactory.new()
var _snake_body_part_factory: SnakeBodyPartFactory = SnakeBodyPartFactory.new()

var _model: GameModel

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
		
func start_new_game() -> void:
	var head: SnakeBodyPart = _snake_body_part_factory.create_new(
		_snake_starting_coordinates, -1, -1
	)
	var walls: Array = []
	for w in _walls_coordinates:
		walls.push_back(_wall_factory.create_new(
			_coordinates_instances[w.get_x() + w.get_y()]
		))
	_model = GameModel.new(
		_field_width,
		_field_height,
		head,
		[], # TODO init
		walls,
		_snake_initial_direction
	)
	
