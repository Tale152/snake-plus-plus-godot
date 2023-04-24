class_name GameController extends Reference

const _EDIBLES_SPAWN_ATTEMPT_FREQUENCY = 1

var _raw_material: ModelRawMaterial
var _exit_game_strategy: FuncRef
var _rng: RandomNumberGenerator = RandomNumberGenerator.new()

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
var _spawn_attempt_elapsed_seconds: float
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
	var existing_effects: Array = EffectType.get_effects()
	var stage_effects_sprite_dictionary: Dictionary = {}
	for perk in _raw_material.get_perks_list():
		if existing_effects.has(perk):
			stage_effects_sprite_dictionary[perk] = _visual_parameters \
				.get_perk_sprite(PerkType.get_perk_type_string(perk))
	_view.initialize(stage_effects_sprite_dictionary, scale)
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
	_view.print_snake(
		snake_units,
		_snake_delta_seconds_calculator.get_last_calculated_delta()
	)

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
		_handle_perks_expire_tick(delta_seconds)
		_handle_equipped_effects_tick(delta_seconds)
		_handle_snake_movement(delta_seconds)
		_update_hud()
		if _snake_properties.is_alive(): _handle_perks_spawn_tick(delta_seconds)

func start_new_game() -> void:
	_view.reset_perks()
	_view.play_game_loop_music()
	_rng.randomize()
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
	_view.resume_animations(_snake_delta_seconds_calculator.get_last_calculated_delta())

func _handle_equipped_effects_tick(delta_seconds: float) -> void:
	var effects_to_print: Array = []
	for effect in _equipped_effects_container.get_equipped_effects():
		var expire_timer: ExpireTimer = effect.get_expire_timer()
		expire_timer.tick(delta_seconds)
		if expire_timer.has_expired():
			_equipped_effects_container.revoke_effect(effect, _snake_properties)
		else:
			effects_to_print.push_back(EquippedEffectTimer.new(
				effect.get_effect_type(),
				int(floor(expire_timer.get_remaining_lifespan_percentage() * 100))
			))
	_view.print_effects(effects_to_print)

func _handle_perks_expire_tick(delta_seconds: float) -> void:
	var perks: Dictionary = _field.get_perks()
	for type in perks.keys():
		for perk in perks[type]:
			perk.get_expire_timer().tick(delta_seconds)
			if perk.get_expire_timer().has_expired():
				_field.remove_perk(perk)
				_view.remove_perk(perk.get_coordinates())
	
func _handle_perks_spawn_tick(delta_seconds: float) -> void:
	_spawn_attempt_elapsed_seconds += delta_seconds
	if _spawn_attempt_elapsed_seconds >= _EDIBLES_SPAWN_ATTEMPT_FREQUENCY:
		_spawn_attempt_elapsed_seconds -= _EDIBLES_SPAWN_ATTEMPT_FREQUENCY
		var empty_coordinates: Array = _field.get_empty_coordinates(
			_snake_properties.get_current_direction()
		)
		for r in _perks_rules:
			if r.can_spawn(_field.count_perks_by_type(r.get_type()), _rng):
				var coord: Coordinates = _get_spawn_coordinates(
					empty_coordinates, r.get_spawn_locations()
				)
				if coord != null:
					_remove_coordinate(empty_coordinates, coord)
					_field.add_perk(Perk.new(
						r.get_type(),
						coord,
						r.get_collision_strategy(),
						r.get_lifespan()
					))
					_view.add_perk(PerkView.new(
						r.get_type_string(),
						coord,
						_visual_parameters
					))

func _get_spawn_coordinates(
	empty_coordinates: Array, rule_spawn_coordinates: Array
) -> Coordinates:
	var choosable: Array
	if rule_spawn_coordinates.size() == 0:
		choosable = empty_coordinates
	else:
		choosable = []
		for r in rule_spawn_coordinates:
			var search = true
			var i = 0
			while(search && i < empty_coordinates.size()):
				if empty_coordinates[i].equals_to(r):
					choosable.push_back(r)
					search = false
				i += 1
	if choosable.size() > 0:
		return choosable[_rng.randi_range(0, choosable.size() - 1)]
	return null

func _remove_coordinate(empty_coordinates: Array, coordinate: Coordinates) -> void:
	var i: int = 0;
	for c in empty_coordinates:
		if c.equals_to(coordinate):
			empty_coordinates.remove(i)
			return
		i += 1

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
		var current_direction: int = _snake_properties.get_current_direction()
		var next_coord: Coordinates = _field.get_coord_from_head(
			current_direction
		)
		var parts = _field.get_snake_body_parts()
		var current_length: int = _snake_properties.get_current_length()
		
		if current_length == _snake_properties.get_potential_length():
			if current_length == 1:
				parts[0] = _body_part_factory.create_new(next_coord, -1, -1)
			else:
				parts.pop_back()
				parts.push_front(_body_part_factory.create_new(
					next_coord, -1, Direction.get_opposite(current_direction)
				))
				parts[1].set_preceding_part_direction(current_direction)
				parts[current_length - 1].set_following_part_direction(-1)
		elif current_length < _snake_properties.get_potential_length():
			parts.push_front(_body_part_factory.create_new(
				next_coord, -1, Direction.get_opposite(current_direction)
			))
			parts[1].set_preceding_part_direction(current_direction)
			if current_length == 1: parts[1].set_following_part_direction(-1)
			_snake_properties.set_current_length(current_length + 1)
		else:
			while(parts.size() > _snake_properties.get_potential_length()):
				parts.pop_back()
			var new_length = parts.size()
			_snake_properties.set_current_length(new_length)
			if new_length == 1:
				parts[0] = _body_part_factory.create_new(next_coord, -1, -1)
			else:
				parts.pop_back()
				parts.push_front(_body_part_factory.create_new(
					next_coord, -1, Direction.get_opposite(current_direction)
				))
				parts[1].set_preceding_part_direction(current_direction)
				parts[new_length - 1].set_following_part_direction(-1)
		_field.set_snake_body_parts(parts)
		_handle_snake_head_collision(parts[0], _field.get_at(next_coord))
		_print_snake()
		if !_snake_properties.is_alive():
			_view.show_game_over_menu()
			_view.stop_game_loop_music()
			_view.play_game_over_sound()
			_view.stop_animations()

func _handle_snake_head_collision(
	head: SnakeBodyPart, next_coord_content: Array
) -> void:
	for collidable in next_coord_content:
		if collidable != head && _snake_properties.is_alive():
			var collision_result: CollisionResult = collidable.execute(
				_snake_properties, _equipped_effects_container
			)
			if collision_result.has_to_be_removed():
				_field.remove_perk(collidable)
				_view.remove_perk(collidable.get_coordinates())
				_view.play_eat_sound()

func _create_new_game_model() -> GameModel:
	var head: SnakeBodyPart = _body_part_factory.create_new(
		_raw_material.get_snake_starting_coordinates(), -1, -1
	)
	var walls: Array = []
	for w in _raw_material.get_walls_coordinates():
		walls.push_back(_raw_material.get_wall_factory().create_new(
			_raw_material.get_coordinates_instances()[(w.get_x() * _raw_material.get_field_height()) + w.get_y()]
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
	_view.stop_animations()

func _resume_game() -> void:
	_is_not_pause = true
	_view.show_controls()
	_view.resume_animations(_snake_delta_seconds_calculator.get_last_calculated_delta())

func _enter_restart() -> void:
	_is_not_pause = false
	_view.show_restart_menu()
	_view.stop_animations()
