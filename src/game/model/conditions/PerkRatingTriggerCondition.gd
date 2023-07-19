class_name PerkRatingTriggerCondition extends RatingTriggerCondition

var _perk_type: int

func _init(
	perk_type: int,
	value: float,
	criteria: String
).(value, criteria):
	_perk_type = perk_type
	
func get_perk_type() -> int:
	return _perk_type
