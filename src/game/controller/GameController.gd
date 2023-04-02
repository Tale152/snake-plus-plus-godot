class_name GameController extends Reference

var _raw_material: ModelRawMaterial

var _model: GameModel
var _body_part_factory: SnakeBodyPartFactory
var _perks_rules: Array
var _elapsed_seconds: float
var _difficulty_settings: DifficultySettings

func _init(
	parsed_stage: ParsedStage,
	difficulty_settings: DifficultySettings
):
	_difficulty_settings = difficulty_settings
	_raw_material = ModelRawMaterial.new(
		parsed_stage,
		_difficulty_settings.get_effects_lifespan_seconds()
	)
	_body_part_factory = _raw_material.get_body_part_factory()
	_perks_rules = _raw_material.get_perks_rules()

func tick(delta_seconds: float) -> void:
	_elapsed_seconds += delta_seconds
	_handle_equipped_effects_tick(delta_seconds)

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
	_elapsed_seconds = 0.0

func _handle_equipped_effects_tick(delta_seconds) -> void:
	var container: EquippedEffectsContainer = _model.get_equipped_effects_container()
	var snake_properties: SnakeProperties = _model._snake_properties()
	for effect in container.get_equipped_effects():
		effect.get_expire_timer().tick(delta_seconds)
		if effect.get_expire_timer().has_expired():
			container.revoke_effect(effect, snake_properties)
