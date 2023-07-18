class_name StageValidatorV1 extends Reference

static func validate(stage: Dictionary) -> bool:
	return (
		_is_field_valid(stage) &&
		_is_snake_valid(stage) &&
		_is_perks_valid(stage) &&
		_is_win_valid(stage) &&
		_is_lose_valid(stage)
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

static func _is_perks_valid(stage: Dictionary) -> bool:
	if !DictionaryUtil.contains(stage, "perks", TYPE_ARRAY): return false
	for perk in stage.perks:
		if typeof(perk) != TYPE_DICTIONARY: return false
		if !DictionaryUtil.contains(perk, "type", TYPE_STRING): return false
		if !_get_v1_perk_types().has(perk.type): return false
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

static func _get_v1_perk_types() -> Array:
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
		PerkType.get_perk_type_string(PerkType.AVOCADO()),
		PerkType.get_perk_type_string(PerkType.CANDY()),
		PerkType.get_perk_type_string(PerkType.LOSS_COIN()),
		PerkType.get_perk_type_string(PerkType.SNAIL()),
		PerkType.get_perk_type_string(PerkType.GHOST()),
		PerkType.get_perk_type_string(PerkType.BEER()),
		PerkType.get_perk_type_string(PerkType.WATERMELON())
	]

static func _is_win_valid(stage: Dictionary) -> bool:
	if !stage.has("conditions"): return true
	if !DictionaryUtil.contains(stage.conditions, "win", TYPE_DICTIONARY): return false
	return _is_condition_structure_valid(stage.conditions.win, stage)

static func _is_lose_valid(stage: Dictionary) -> bool:
	if !stage.has("conditions"): return true
	if !stage.conditions.has("win") && !stage.conditions.has("lose"): return true
	if stage.conditions.has("win") && !stage.conditions.has("lose"): return true
	if !DictionaryUtil.contains(stage.conditions, "lose", TYPE_DICTIONARY): return false
	return _is_condition_structure_valid(stage.conditions.lose, stage)

static func _is_condition_structure_valid(
	conditions_structure: Dictionary, stage: Dictionary
) -> bool:
	var conditionsToTrigger = 0
	if DictionaryUtil.contains(conditions_structure, "time", TYPE_REAL):
		if conditions_structure.time < 0.0: return false
		conditionsToTrigger += 1
	elif conditions_structure.has("time"): return false
	
	if DictionaryUtil.contains(conditions_structure, "length", TYPE_REAL):
		if conditions_structure.length < 1: return false
		conditionsToTrigger += 1
	elif conditions_structure.has("length"): return false

	if DictionaryUtil.contains(conditions_structure, "score", TYPE_REAL):
		if conditions_structure.score < 1: return false
		conditionsToTrigger += 1
	elif conditions_structure.has("score"): return false
	
	if DictionaryUtil.contains(conditions_structure, "perks", TYPE_ARRAY):
		var perks = conditions_structure.perks
		if perks.size() == 0: return false
		var parsed_perk_types = []
		var stage_perk_types = []
		for perk in stage.perks:
			stage_perk_types.append(perk.type)
		for perk in perks:
			if !_is_array_of_size(perk, 2): return false
			var perk_type = perk[0]
			if !typeof(perk_type) == TYPE_STRING: return false
			if !_get_v1_perk_types().has(perk_type): return false
			if !stage_perk_types.has(perk_type): return false
			var perk_quantity = perk[1]
			if !typeof(perk_quantity) == TYPE_REAL: return false
			if perk_quantity < 1: return false
			parsed_perk_types.append(perk_type)
		while(parsed_perk_types.size() > 0):
			var p = parsed_perk_types.pop_back()
			if parsed_perk_types.has(p): return false
		conditionsToTrigger += 1
	elif conditions_structure.has("perks"): return false

	return conditionsToTrigger > 0 
