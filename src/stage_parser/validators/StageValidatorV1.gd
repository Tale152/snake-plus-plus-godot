class_name StageValidatorV1 extends Reference

static func validate(stage: Dictionary) -> bool:
	return (
		_is_field_valid(stage) &&
		_is_snake_valid(stage) &&
		_is_perks_valid(stage) &&
		_is_win_ratings_valid(stage) &&
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

static func _is_win_ratings_valid(stage: Dictionary) -> bool:
	if !stage.has("conditions"): return true
	if !DictionaryUtil.contains(stage, "conditions", TYPE_DICTIONARY):
		printerr("conditions found but type mismatch")
		return false
	if !DictionaryUtil.contains(stage.conditions, "win_ratings", TYPE_ARRAY):
		printerr("conditions do not contain a win ratings array")
		return false
	if !_is_array_of_size(stage.conditions.win_ratings, 3):
		printerr("conditions' win ratings array's size must be 3")
		return false
	var stars: Array = []
	for rating in stage.conditions.win_ratings:
		stars.push_back(_check_single_rating_structure(rating, stage))
	if !stars.has(1):
		printerr("conditions' win ratings array's does not contain a valid rating object for stars 1")
		return false
	if !stars.has(2):
		printerr("conditions' win ratings array's does not contain a valid rating object for stars 2")
		return false
	if !stars.has(3):
		printerr("conditions' win ratings array's does not contain a valid rating object for stars 3")
		return false
	return true

static func _check_single_rating_structure(rating: Dictionary, stage: Dictionary) -> int:
	if !DictionaryUtil.contains(rating, "stars", TYPE_REAL): return -1
	var stars = rating.stars
	var valid_criteria = 0
	valid_criteria += _check_rating_value(rating, "score", 1, stars)
	valid_criteria += _check_rating_value(rating, "time", 1, stars)
	valid_criteria += _check_rating_value(rating, "length", 1, stars)
	if rating.has("perks"):
		if !DictionaryUtil.contains(rating, "perks", TYPE_ARRAY):
			printerr("the rating for stars " + stars + " contains a perks field that is not an array")
			return -1
		var perk_types_found: Array = []
		var rating_perks = rating.perks
		if rating_perks.size() == 0:
			printerr("the rating for stars " + stars + " contains an empty perks array")
			return -1
		var stage_perk_types = [] #every perk type contained in the stage
		for perk in stage.perks:
			stage_perk_types.append(perk.type)
		for rp in rating_perks:
			if _generic_check_rating(rp, 1, stars) < 1: return -1
			if !DictionaryUtil.contains(rp, "type", TYPE_STRING):
				printerr("the rating for stars " + str(stars) + " perks array contains a perk which type is not a string")
				return -1
			if !_get_v1_perk_types().has(rp.type):
				printerr("the rating for stars " + str(stars) + " perks array contains a perk which type " + rp.type + " does not exist")
				return -1
			if !stage_perk_types.has(rp.type):
				printerr("the rating for stars " + str(stars) + " perks array contains a perk which type " + rp.type + " cannot spawn in the stage")
				return -1
			perk_types_found.push_back(rp.type)
		# duplicates check
		while(perk_types_found.size() > 0):
			var p = perk_types_found.pop_back()
			if perk_types_found.has(p):
				printerr("the rating for stars " + str(stars) + " perks array contains a perk which type " + p + " appears more than once")
				return -1
	if valid_criteria > 0: return int(stars)
	printerr("the rating for stars " + str(stars) + " does not contain at least one valid criteria")
	return -1

static func _check_rating_value(
	rating: Dictionary,
	value_string: String,
	min_value: int,
	stars
) -> int:
	if !rating.has(value_string): return 0
	if !DictionaryUtil.contains(rating, value_string, TYPE_DICTIONARY):
		printerr("the rating for stars " + str(stars) + " contains the criteria " + value_string + " which is not a dictionary")
		return -100
	return _generic_check_rating(rating[value_string], min_value, stars)

static func _generic_check_rating(
	value_dictionary: Dictionary,
	min_value: int,
	stars
) -> int:
	if !DictionaryUtil.contains(value_dictionary, "value", TYPE_REAL):
		printerr("the rating for stars " + str(stars) + " contains a criteria which value is not a number")
		return -100
	if value_dictionary.value < min_value:
		printerr("the rating for stars " + str(stars) + " contains a criteria which value is less than " + str(min_value))
		return -100
	if !DictionaryUtil.contains(value_dictionary, "criteria", TYPE_STRING):
		printerr("the rating for stars " + str(stars) + " contains a criteria in which the criteria value is not a string")
		return -100
	if value_dictionary.criteria != "reach" && value_dictionary.criteria != "below":
		printerr("the rating for stars " + str(stars) + " contains a criteria in which the criteria value is neither 'reach' or 'below'")
		return -100
	return 1

static func _is_lose_valid(stage: Dictionary) -> bool:
	if !stage.has("conditions"): return true
	if !DictionaryUtil.contains(stage, "conditions", TYPE_DICTIONARY): return false
	if !DictionaryUtil.contains(stage.conditions, "lose", TYPE_DICTIONARY): return false
	var conditions_structure: Dictionary = stage.conditions.lose
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
