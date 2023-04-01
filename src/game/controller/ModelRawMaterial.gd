class_name ModelRawMaterial extends Reference

var _field_width: int
var _field_height: int
var _coordinates_instances: Array = []
var _snake_starting_coordinates: Coordinates
var _snake_initial_direction: int
var _walls_coordinates: Array = []
var _perks_rules: Array = []

func _init(parsed_stage: ParsedStage):
	_field_width = parsed_stage.get_field_width()
	_field_height = parsed_stage.get_field_width()

	for x in range(0, parsed_stage.get_field_height()):
		for y in range(0, parsed_stage.get_field_width()):
			_coordinates_instances.push_back(Coordinates.new(x, y))

	var spawn: Vector2 = parsed_stage.get_snake_spawn_point()
	_snake_starting_coordinates = _coordinates_instances[spawn.x + spawn.y]
	_snake_initial_direction = parsed_stage.get_snake_initial_direction()

	for wl in parsed_stage.get_walls_points():
		var wall_location: Vector2 = wl
		_walls_coordinates.push_back(
			_coordinates_instances[wall_location.x + wall_location.y]
		)

	for r in parsed_stage.get_perks_rules():
		var parsed_rule: ParsedPerkRules = r
		var spawn_locations = []
		for l in parsed_rule.get_spawn_locations():
			var spawn_location: Vector2 = l
			spawn_locations.push_back(
				_coordinates_instances[spawn_location.x + spawn_location.y]
			)
		var type: int = PerkType.get_perk_type_int(parsed_rule.get_type())
		_perks_rules.push_back(PerkRules.new(
			type,
			spawn_locations,
			parsed_rule.get_spawn_probability(),
			parsed_rule.get_lifespan(),
			parsed_rule.get_max_instances(),
			PerkStrategiesFactory.create_collision_strategy(type)
		))

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

func get_perks_rules() -> Array:
	return _perks_rules
