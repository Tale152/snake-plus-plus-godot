class_name EquippedEffectTimer extends Reference

var _effect_type: int
var _percentage: int

func _init(effect_type: int, percentage: int):
	_effect_type = effect_type
	_percentage = percentage

func get_effect_type() -> int:
	return _effect_type

func get_percentage() -> int:
	return _percentage
