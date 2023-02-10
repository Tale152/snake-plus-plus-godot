class_name Player extends Reference

var _points: int = 0
var _multiplier: int = 1

func get_points() -> int:
	return _points

func set_points(points: int) -> void:
	_points = points

func get_multiplier() -> int:
	return _multiplier

func set_multiplier(multiplier: int) -> void:
	_multiplier = multiplier
