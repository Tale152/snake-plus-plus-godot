class_name GameController extends Reference

var _raw_material: ModelRawMaterial
var _wall_factory: WallFactory = WallFactory.new()
var _snake_body_part_factory: SnakeBodyPartFactory = SnakeBodyPartFactory.new()

var _model: GameModel

func _init(parsed_stage: ParsedStage):
	_raw_material = ModelRawMaterial.new(parsed_stage)
		
func start_new_game() -> void:
	_model = null
	var head: SnakeBodyPart = _snake_body_part_factory.create_new(
		_raw_material.get_snake_starting_coordinates(), -1, -1
	)
	var walls: Array = []
	for w in _raw_material.get_walls_coordinates():
		walls.push_back(_wall_factory.create_new(
			_raw_material.get_coordinates_instances()[w.get_x() + w.get_y()]
		))
	_model = GameModel.new(
		_raw_material.get_field_width(),
		_raw_material.get_field_height(),
		head,
		[], # TODO init
		walls,
		_raw_material.get_snake_initial_direction()
	)
	
