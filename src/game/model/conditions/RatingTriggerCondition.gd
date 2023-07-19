class_name RatingTriggerCondition extends Reference

var _value: float
var _criteria: String

func _init(value: float, criteria: String):
	_value = value
	_criteria = criteria

func get_value() -> float:
	return _value

func get_criteria() -> String:
	return _criteria
