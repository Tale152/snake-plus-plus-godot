class_name GameController extends Reference

var _raw_material: ModelRawMaterial

var _model: GameModel
var _field: Field
var _view
var _body_part_factory: SnakeBodyPartFactory
var _wall_factory: WallFactory
var _perks_rules: Array
var _elapsed_seconds: float
var _difficulty_settings: DifficultySettings
var _visual_parameters: VisualParameters

func _init(
	parsed_stage: ParsedStage,
	difficulty_settings: DifficultySettings,
	visual_parameters: VisualParameters
):
	_difficulty_settings = difficulty_settings
	_visual_parameters = visual_parameters
	_raw_material = ModelRawMaterial.new(
		parsed_stage,
		_difficulty_settings.get_effects_lifespan_seconds()
	)
	_body_part_factory = _raw_material.get_body_part_factory()
	_wall_factory = _raw_material.get_wall_factory()
	_perks_rules = _raw_material.get_perks_rules()

func set_view(view) -> void:
	_view = view
	_print_background()
	_print_walls()

func _print_background() -> void:
	for coord in _raw_material.get_coordinates_instances():
		_view.add_background_cell(BackgroundCell.new(
			coord, _visual_parameters
		))

func _print_walls() -> void:
	var walls_coordinates = _raw_material.get_walls_coordinates()
	for coord in walls_coordinates:
		_view.add_wall(WallView.new(
			coord,
			ConnectionsCalculator.generate_connections(
				coord,
				walls_coordinates,
				_raw_material.get_field_width(),
				_raw_material.get_field_height()
			),
			 _visual_parameters
		))

func _print_snake() -> void:
	var head: SnakeBodyPart = _field.get_snake_body_parts()[0]
	var snake_units: Array = [
		SnakeUnitView.new(
			_visual_parameters,
			SnakeUnitPlacement.new(
				head.get_coordinates(),
				_model.get_snake_properties().get_current_direction(),
				head.get_following_part_direction(),
				true
			)
		)
	]
	var i: int = 1
	while(i < _model.get_snake_properties().get_current_length()):
		var part: SnakeBodyPart = _field.get_snake_body_parts()[i]
		snake_units.push_back(
			SnakeUnitView.new(
				_visual_parameters,
				SnakeUnitPlacement.new(
					part.get_coordinates(),
					part.get_preceding_part_direction(),
					part.get_following_part_direction(),
					false
				)
			)
		)
		i += 1
	_view.print_snake(snake_units)

func tick(delta_seconds: float) -> void:
	_elapsed_seconds += delta_seconds
	_handle_equipped_effects_tick(delta_seconds)
	# if movement _print_snake()
	_update_hud()

func start_new_game() -> void:
	_elapsed_seconds = 0.0
	_model = _create_new_game_model()
	_field = _model.get_field()
	_update_hud()
	_print_snake()

func _handle_equipped_effects_tick(delta_seconds) -> void:
	var container: EquippedEffectsContainer = _model.get_equipped_effects_container()
	var snake_properties: SnakeProperties = _model._snake_properties()
	for effect in container.get_equipped_effects():
		effect.get_expire_timer().tick(delta_seconds)
		if effect.get_expire_timer().has_expired():
			container.revoke_effect(effect, snake_properties)

func _create_new_game_model() -> GameModel:
	var head: SnakeBodyPart = _body_part_factory.create_new(
		_raw_material.get_snake_starting_coordinates(), -1, -1
	)
	var walls: Array = []
	for w in _raw_material.get_walls_coordinates():
		walls.push_back(_raw_material.get_wall_factory().create_new(
			_raw_material.get_coordinates_instances()[w.get_x() + w.get_y()]
		))
	return GameModel.new(
		_raw_material.get_field_width(),
		_raw_material.get_field_height(),
		head,
		_raw_material.get_perks_list(),
		walls,
		_raw_material.get_snake_initial_direction()
	)

func _update_hud() -> void:
	_view.update_hud(
		_model.get_snake_properties().get_score(),
		_model.get_snake_properties().get_current_length(),
		_elapsed_seconds
	)
