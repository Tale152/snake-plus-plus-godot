class_name ValidatorV1 extends Reference

static func validate(stage: Dictionary) -> bool:
	return (
		_is_field_valid(stage) &&
		_is_snake_valid(stage) &&
		_is_edibles_valid(stage)
	)

static func _is_field_valid(stage: Dictionary) -> bool:
	if !DictionaryUtil.contains(stage, "field", TYPE_DICTIONARY): return false
	if !DictionaryUtil.contains(stage.field, "size", TYPE_ARRAY): return false
	if stage.field.size.size() != 2: return false
	for dimension in stage.field.size:
		if typeof(dimension) != TYPE_REAL: return false
	if !DictionaryUtil.contains(stage.field, "walls", TYPE_ARRAY): return false
	for wall in stage.field.walls:
		if !_is_array_of_size(wall, 2): return false
		for coord in wall:
			if typeof(coord) != TYPE_REAL: return false
	return true

static func _is_snake_valid(stage: Dictionary) -> bool:
	if !DictionaryUtil.contains(stage, "snake", TYPE_DICTIONARY): return false
	if !DictionaryUtil.contains(stage.snake, "spawn", TYPE_ARRAY): return false
	if !_is_array_of_size(stage.snake.spawn, 2): return false
	if !DictionaryUtil.contains(stage.snake, "direction", TYPE_REAL): return false
	return true

static func _is_edibles_valid(stage: Dictionary) -> bool:
	if !DictionaryUtil.contains(stage, "perks", TYPE_ARRAY): return false
	for perk in stage.perks:
		if typeof(perk) != TYPE_DICTIONARY: return false
		if !DictionaryUtil.contains(perk, "type", TYPE_STRING): return false
		if !_get_v1_edible_types().has(perk.type): return false
		if !DictionaryUtil.contains(perk, "max_instances", TYPE_REAL): return false
		if !_is_not_contained_or_typed(perk, "spawn_probability", TYPE_REAL): return false
		if !_is_not_contained_or_typed(perk, "lifespan", TYPE_REAL): return false
		if !_is_not_contained_or_typed(perk, "spawn_locations", TYPE_ARRAY): return false
		if !DictionaryUtil.does_not_contain(perk, "spawn_locations"):
			for location in perk.spawn_locations:
				if !_is_array_of_size(location, 2): return false
				for coord in location:
					if typeof(coord) != TYPE_REAL: return false
	return true

static func _is_array_of_size(value, size: int) -> bool:
	return typeof(value) == TYPE_ARRAY || value.size() == size

static func _is_not_contained_or_typed(d: Dictionary, value: String, type: int) -> bool:
	return DictionaryUtil.contains(d, value, type) || DictionaryUtil.does_not_contain(d, value)

static func _get_v1_edible_types() -> Array:
	return [
		PerkType.get_perk_type_string(PerkType.APPLE()),
		PerkType.get_perk_type_string(PerkType.LEMON()),
		PerkType.get_perk_type_string(PerkType.CHERRY()),
		PerkType.get_perk_type_string(PerkType.ORANGE()),
		PerkType.get_perk_type_string(PerkType.CHILI()),
		PerkType.get_perk_type_string(PerkType.STAR()),
		PerkType.get_perk_type_string(PerkType.GAIN_COIN()),
		PerkType.get_perk_type_string(PerkType.DIAMOND()),
		PerkType.get_perk_type_string(PerkType.BANANA()),
		PerkType.get_perk_type_string(PerkType.AVOCADO())
	]
