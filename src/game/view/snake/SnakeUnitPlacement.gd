class_name SnakeUnitPlacement extends Reference

var _coordinates: Coordinates
var _next_direction: int
var _previous_direction: int
var _is_head: bool

func _init(
	cordinates: Coordinates,
	next_direction: int,
	previous_direction: int,
	is_head: bool
):
	_coordinates = cordinates
	_next_direction = next_direction
	_previous_direction = previous_direction
	_is_head = is_head

func get_coordinates() -> Coordinates:
	return _coordinates

func get_next_direction() -> int:
	return _next_direction

func get_previous_direction() -> int:
	return _previous_direction

func is_head() -> bool: return _is_head
