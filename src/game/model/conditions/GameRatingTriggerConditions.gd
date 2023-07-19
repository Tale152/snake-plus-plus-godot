class_name GameRatingTriggerConditions extends Reference

var _stars: int
var _score_trigger: RatingTriggerCondition = null
var _time_trigger: RatingTriggerCondition = null
var _length_trigger: RatingTriggerCondition = null
var _perks_trigger: Array = []

func _init(trigger_conditions_dictionary: Dictionary):
	_stars = int(trigger_conditions_dictionary.stars)
	_score_trigger = _create_rating_trigger_condition("score", trigger_conditions_dictionary)
	_time_trigger = _create_rating_trigger_condition("time", trigger_conditions_dictionary)
	_length_trigger = _create_rating_trigger_condition("length", trigger_conditions_dictionary)
	if trigger_conditions_dictionary.has("perks"):
		for perk in trigger_conditions_dictionary.perks:
			_perks_trigger.push_back(PerkRatingTriggerCondition.new(
				PerkType.get_perk_type_int(str(perk.perk_type)),
				float(perk.value),
				str(perk.criteria)
			))

func get_stars() -> int:
	return _stars

func get_score_trigger() -> RatingTriggerCondition:
	return _score_trigger

func get_time_trigger() -> RatingTriggerCondition:
	return _time_trigger

func get_length_trigger() -> RatingTriggerCondition:
	return _length_trigger

func get_perk_triggers() -> Array:
	return _perks_trigger

func are_conditions_satisfied(
	score: int, time: float, length: int, perk_collision_trackers: Array
) -> bool:
	for perk_trigger in _perks_trigger:
		var perk_collision_tracker: PerkCollisionsTracker = _get_perk_collision_tracker(
			perk_trigger, perk_collision_trackers
		)
		if perk_trigger.get_criteria() == "reach":
			if perk_collision_tracker.get_counter() < perk_trigger.get_value(): return false
		else:
			if perk_collision_tracker.get_counter() >= perk_trigger.get_value(): return false
	return (
		_is_rating_trigger_reached(score, _score_trigger) &&
		_is_rating_trigger_reached(time, _time_trigger) &&
		_is_rating_trigger_reached(length, _length_trigger)
	)

func _get_perk_collision_tracker(
	perk_rating_trigger_condition: PerkRatingTriggerCondition,
	perk_collision_trackers: Array
) -> PerkCollisionsTracker:
	for perk_collision_tracker in perk_collision_trackers:
		if perk_collision_tracker.get_perk_type() == perk_rating_trigger_condition.get_perk_type():
			return perk_collision_tracker
	return null #impossible unless preliminary check on stage is broken

func _create_rating_trigger_condition(
	condition_name: String,
	trigger_conditions_dictionary: Dictionary
):
	if trigger_conditions_dictionary.has(condition_name):
		return RatingTriggerCondition.new(
			float(trigger_conditions_dictionary[condition_name].value),
			str(trigger_conditions_dictionary[condition_name].criteria)
		)
	return null

func _is_rating_trigger_reached(value, trigger: RatingTriggerCondition) -> bool:
	if trigger == null: return true
	if trigger.get_criteria() == "reach":
		if value >= trigger.get_value(): return true
	else:
		if value < trigger.get_value(): return true
	return false
