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

func get_stars() -> int:
	return _stars

func get_score_trigger() -> RatingTriggerCondition:
	return _score_trigger

func get_time_trigger() -> RatingTriggerCondition:
	return _time_trigger

func get_length_trigger() -> RatingTriggerCondition:
	return _length_trigger

func are_conditions_satisfied(score: int, time: float, length: int) -> bool:
	return (
		_is_rating_trigger_reached(score, _score_trigger) &&
		_is_rating_trigger_reached(time, _time_trigger) &&
		_is_rating_trigger_reached(length, _length_trigger)
	)

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
