class_name GameController extends Reference

var _raw_material: ModelRawMaterial

var _model: GameModel
var _body_part_factory: SnakeBodyPartFactory
var _perks_rules: Array

func _init(parsed_stage: ParsedStage, effects_lifespan_seconds: float):
	_raw_material = ModelRawMaterial.new(parsed_stage, effects_lifespan_seconds)
	_body_part_factory = _raw_material.get_body_part_factory()
	_perks_rules = _raw_material.get_perks_rules()

func start_new_game() -> void:
	var head: SnakeBodyPart = _body_part_factory.create_new(
		_raw_material.get_snake_starting_coordinates(), -1, -1
	)
	var walls: Array = []
	for w in _raw_material.get_walls_coordinates():
		walls.push_back(_raw_material.get_wall_factory().create_new(
			_raw_material.get_coordinates_instances()[w.get_x() + w.get_y()]
		))
	_model = GameModel.new(
		_raw_material.get_field_width(),
		_raw_material.get_field_height(),
		head,
		_raw_material.get_perks_list(),
		walls,
		_raw_material.get_snake_initial_direction()
	)
