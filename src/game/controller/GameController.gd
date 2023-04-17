class_name GameController extends Reference

var _raw_material: ModelRawMaterial
var _exit_game_strategy: FuncRef

var _model: GameModel
var _snake_properties: SnakeProperties
var _field: Field
var _view
var _body_part_factory: SnakeBodyPartFactory
var _wall_factory: WallFactory
var _perks_rules: Array
var _is_not_pause: bool
var _elapsed_seconds: float
var _movement_elapsed_seconds: float
var _snake_delta_seconds_calculator: SnakeDeltaSecondsCalculator
var _game_direction_input_handler: GameDirectionInputHandler
var _equipped_effects_container: EquippedEffectsContainer
var _difficulty_settings: DifficultySettings
var _visual_parameters: VisualParameters

func _init(
	parsed_stage: ParsedStage,
	difficulty_settings: DifficultySettings,
	visual_parameters: VisualParameters,
	exit_game_strategy: FuncRef
):
	_exit_game_strategy = exit_game_strategy
	_difficulty_settings = difficulty_settings
	_visual_parameters = visual_parameters
	_raw_material = ModelRawMaterial.new(
		parsed_stage,
		_difficulty_settings.get_effects_lifespan_seconds()
	)
	_body_part_factory = _raw_material.get_body_part_factory()
	_wall_factory = _raw_material.get_wall_factory()
	_perks_rules = _raw_material.get_perks_rules()
	_snake_delta_seconds_calculator = SnakeDeltaSecondsCalculator.new(
		_difficulty_settings.get_base_delta_seconds(),
		_difficulty_settings.get_speedup_factor()
	)
	_game_direction_input_handler = GameDirectionInputHandler.new()

func is_not_game_over() -> bool:
	return _snake_properties.is_alive()

func set_view(view, scale: float) -> void:
	_view = view
	_view.scale(scale)
	InputBinder.bind(self, view, _exit_game_strategy)
	_print_background()
	_print_walls()

func direction_input(input: int) -> void:
	_game_direction_input_handler.submit_input(
		_snake_properties.get_current_direction(),
		input,
		_movement_elapsed_seconds,
		_snake_delta_seconds_calculator.get_last_calculated_delta()
	)

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
	var snake_units: Array = [_create_snake_unit_view(
		head, _snake_properties.get_current_direction(), true
	)]
	for i in range(1, _snake_properties.get_current_length()):
		var part: SnakeBodyPart = _field.get_snake_body_parts()[i]
		snake_units.push_back(_create_snake_unit_view(
			part, part.get_preceding_part_direction(), false
		))
	_view.print_snake(snake_units, 1) # TODO hardcoded speed_scale

func _create_snake_unit_view(
	snake_body_part: SnakeBodyPart,
	following_direction: int,
	is_head: bool
) -> SnakeUnitView:
	return SnakeUnitView.new(
			_visual_parameters,
			SnakeUnitPlacement.new(
				snake_body_part.get_coordinates(),
				following_direction,
				snake_body_part.get_following_part_direction(),
				is_head
			)
		)

func tick(delta_seconds: float) -> void:
	if _is_not_pause:
		_elapsed_seconds += delta_seconds
		_handle_equipped_effects_tick(delta_seconds)
		_handle_snake_movement(delta_seconds)
		_update_hud()

func start_new_game() -> void:
	_is_not_pause = true
	_elapsed_seconds = 0.0
	_movement_elapsed_seconds = 0.0
	_game_direction_input_handler.reset()
	_model = _create_new_game_model()
	_field = _model.get_field()
	_snake_properties = _model.get_snake_properties()
	_snake_delta_seconds_calculator.calculate_current_delta_seconds(
		_snake_properties.get_current_length() - 1,
		_snake_properties.get_speed_multiplier()
	)
	_equipped_effects_container = _model.get_equipped_effects_container()
	_update_hud()
	_print_snake()
	_view.show_controls()

func _handle_equipped_effects_tick(delta_seconds) -> void:
	for effect in _equipped_effects_container.get_equipped_effects():
		effect.get_expire_timer().tick(delta_seconds)
		if effect.get_expire_timer().has_expired():
			_equipped_effects_container.revoke_effect(effect, _snake_properties)

func _handle_snake_movement(delta: float) -> void:
	_movement_elapsed_seconds += delta
	var current_snake_delta_seconds = _snake_delta_seconds_calculator.calculate_current_delta_seconds(
		_snake_properties.get_current_length() - 1,
		_snake_properties.get_speed_multiplier()
	)
	if _movement_elapsed_seconds >= current_snake_delta_seconds:
		_movement_elapsed_seconds -= current_snake_delta_seconds
		var next= _game_direction_input_handler.get_next_direction()
		if next != -1:
			_snake_properties.set_current_direction(next)
		#_snake.move(current_snake_delta_seconds)
		#_handle_snake_collision()
		_print_snake()

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
		_snake_properties.get_score(),
		_snake_properties.get_current_length(),
		_elapsed_seconds
	)

func _up_direction_input() -> void: direction_input(Direction.UP())

func _right_direction_input() -> void: direction_input(Direction.RIGHT())

func _down_direction_input() -> void: direction_input(Direction.DOWN())

func _left_direction_input() -> void: direction_input(Direction.LEFT())

func _enter_pause() -> void:
	_is_not_pause = false
	_view.show_pause_menu()

func _resume_game() -> void:
	_is_not_pause = true
	_view.show_controls()

func _enter_restart() -> void:
	_is_not_pause = false
	_view.show_restart_menu()
