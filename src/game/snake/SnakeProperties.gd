class_name SnakeProperties extends Reference

var _current_length: int = 1
var _potential_length: int = 1
var _current_direction: int

func _init(initial_direction: int):
	_current_direction = initial_direction

func get_current_length() -> int:
	return _current_length

func set_current_length(l: int) -> void:
	_current_length = l

func get_potential_length() -> int:
	return _potential_length

func set_potential_length(l: int) -> void:
	_potential_length = l

func get_current_direction() -> int:
	return _current_direction

func set_current_direction(d: int) -> void:
	_current_direction = d
