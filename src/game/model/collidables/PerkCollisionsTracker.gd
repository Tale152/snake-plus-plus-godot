class_name PerkCollisionsTracker extends Reference

var _perk_type: int
var _counter: int = 0

func _init(perk_type: int):
	_perk_type = perk_type

func get_perk_type() -> int:
	return _perk_type

func get_counter() -> int:
	return _counter

func increase_counter() -> void:
	_counter += 1
