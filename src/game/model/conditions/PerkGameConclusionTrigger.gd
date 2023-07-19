class_name PerkGameConclusionTrigger extends Reference

var _perk_type: int
var _trigger_value: int

func _init(perk_type: int, trigger_value: int):
	_perk_type = perk_type
	_trigger_value = trigger_value

func get_perk_type() -> int:
	return _perk_type

func get_trigger_value() -> int:
	return _trigger_value
