class_name ImmutablePoint extends Reference

var _x: int
var _y: int

func _init(x: int, y: int):
	_x = x
	_y = y

func get_x() -> int:
	return _x

func get_y() -> int:
	return _y

func equals_to(point: ImmutablePoint) -> bool:
	return _x == point.get_x() && _y == point.get_y()

static func get_point_index_in_array(array, point) -> int:
	var i = 0
	for p in array:
		if p.equals_to(point):
			return i
		i += 1
	return -1
