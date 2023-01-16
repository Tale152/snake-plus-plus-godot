class_name StageDescriptionBuilder extends Reference

const DIRECTIONS = preload("res://src/enums/DirectionsEnum.gd").DIRECTIONS

var _size: FieldSize = null
var _snake_spawn_point: ImmutablePoint = null
var _snake_initial_direction: int = -1
var _snake_base_delta_seconds: float = -1
var _snake_speedup_factor: float = -1
var _instantaneous_edible_rules: Array = []

func set_field_size(size: FieldSize) -> StageDescriptionBuilder:
	_size = size
	return self

func set_snake_spawn_point(point: ImmutablePoint) -> StageDescriptionBuilder:
	_snake_spawn_point = point
	return self

func set_snake_initial_direction(direction: int) -> StageDescriptionBuilder:
	_snake_initial_direction = direction
	return self

func set_snake_base_delta_seconds(delta_seconds) -> StageDescriptionBuilder:
	_snake_base_delta_seconds = delta_seconds
	return self

func set_snake_speedup_factor(speedup_factor: float) -> StageDescriptionBuilder:
	_snake_speedup_factor = speedup_factor
	return self

func add_instantaneous_edible_rules(rules: InstantaneousEdibleRules) -> StageDescriptionBuilder:
	_instantaneous_edible_rules.push_back(rules)
	return self
	
func build() -> StageDescription:
	if _all_check_pass():
		return StageDescription.new(
			_size,
			_snake_spawn_point,
			_snake_initial_direction,
			_snake_base_delta_seconds,
			_snake_speedup_factor,
			_instantaneous_edible_rules
		)
	else:
		return null

func _all_check_pass() -> bool:
	return (
		_is_field_size_valid()
		&& _is_snake_spawn_point_valid()
		&& _is_snake_initial_direction_valid()
		&& _is_snake_base_delta_seconds_valid()
		&& _is_snake_speedup_factor_valid()
		&& _are_all_instantaneous_edibles_rules_valid()
	)
func _is_field_size_valid():
	return _size != null && _size.get_height() > 0 && _size.get_width() > 0

func _is_snake_spawn_point_valid():
	return _snake_spawn_point != null && is_point_in_field(_snake_spawn_point)

func _is_snake_initial_direction_valid():
	return (
		_snake_initial_direction == DIRECTIONS.UP
		|| _snake_initial_direction == DIRECTIONS.DOWN
		|| _snake_initial_direction == DIRECTIONS.LEFT
		|| _snake_initial_direction == DIRECTIONS.RIGHT
	)

func _is_snake_base_delta_seconds_valid():
	return _snake_base_delta_seconds > 0

func _is_snake_speedup_factor_valid():
	return _snake_speedup_factor > 0

func _are_all_instantaneous_edibles_rules_valid():
	# check rules are valid and that there are not multiple rules for same type
	var types = []
	for r in _instantaneous_edible_rules:
		if !_is_instantaneous_edible_rules_valid(r) || types.find(r.get_type()) != -1:
			return false
		types.push_back(r.get_type())
	return true
	
	
func _is_instantaneous_edible_rules_valid(r: InstantaneousEdibleRules):
	# checking type, spawn_probability, life_span and max_instances
	if !(
		InstantaneousEdiblesTypes.get_types().find(r.get_type()) != -1
		&& r.get_spawn_probability() > 0 && r.get_spawn_probability() <= 1
		&& (r.get_life_span() == - 1 || r.get_life_span() > 0)
		&& r.get_max_instances() > 0
	):
		return false
	# checking spawn_locations are in field and not duplicated
	var i = 0
	for l in r.get_spawn_locations():
		if !is_point_in_field(l):
			return false
		var j = i + 1
		while j < r.get_spawn_locations().size():
			if l.equals_to(r.get_spawn_locations()[j]):
				return false
			j += 1
		i += 1
	# returning true if everything is ok
	return true

func is_point_in_field(p: ImmutablePoint) -> bool:
	return (
		p.get_x() >= 0 && p.get_x() < _size.get_width()
		&& p.get_y() >= 0 && p.get_y() < _size.get_height()
	)
