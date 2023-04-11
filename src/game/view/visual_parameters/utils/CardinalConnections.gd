class_name CardinalConnections extends Reference

var _is_up_connected: bool
var _is_right_connected: bool
var _is_down_connected: bool
var _is_left_connected: bool

func _init(connections: Array):
	_is_up_connected = connections.find(Direction.UP()) != - 1
	_is_right_connected = connections.find(Direction.RIGHT()) != - 1
	_is_down_connected = connections.find(Direction.DOWN()) != - 1
	_is_left_connected = connections.find(Direction.LEFT()) != - 1

func is_connected_to(direction: int) -> bool:
	if direction == Direction.UP(): return _is_up_connected
	elif direction == Direction.RIGHT(): return _is_right_connected
	elif direction == Direction.DOWN(): return _is_down_connected
	elif direction == Direction.LEFT(): return _is_left_connected
	else: return false

func equals_to(cardinal_connections: CardinalConnections) -> bool:
	for d in Direction.get_directions():
		if is_connected_to(d) != cardinal_connections.is_connected_to(d):
			return false
	return true
