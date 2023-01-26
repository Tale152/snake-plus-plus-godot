class_name Placement extends Reference

var _coordinates: ImmutablePoint
var _next_direction: int
var _previous_direction: int

func _init(
	cordinates: ImmutablePoint,
	next_direction: int,
	previous_direction: int
):
	_coordinates = cordinates
	_next_direction = next_direction
	_previous_direction = previous_direction

func get_coordinates() -> ImmutablePoint:
	return _coordinates

func set_coordinates(c: ImmutablePoint) -> void:
	_coordinates = c

func get_next_direction() -> int:
	return _next_direction

func set_next_direction(d: int) -> void:
	_next_direction = d

func get_previous_direction() -> int:
	return _previous_direction

func set_previous_direction(d: int) -> void:
	_previous_direction = d
