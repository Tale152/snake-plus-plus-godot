class_name CardinalConnections extends Reference

var _is_up_connected: bool
var _is_right_connected: bool
var _is_down_connected: bool
var _is_left_connected: bool

func _init(connections: Array):
	_is_up_connected = connections.find(Directions.get_up()) != - 1
	_is_right_connected = connections.find(Directions.get_right()) != - 1
	_is_down_connected = connections.find(Directions.get_down()) != - 1
	_is_left_connected = connections.find(Directions.get_left()) != - 1

func is_connected_to(direction: int) -> bool:
	if direction == Directions.get_up(): return _is_up_connected
	elif direction == Directions.get_right(): return _is_right_connected
	elif direction == Directions.get_down(): return _is_down_connected
	elif direction == Directions.get_left(): return _is_left_connected
	else: return false

func equals_to(cardinal_connections: CardinalConnections) -> bool:
	for d in Directions.get_directions():
		if is_connected_to(d) != cardinal_connections.is_connected_to(d):
			return false
	return true
