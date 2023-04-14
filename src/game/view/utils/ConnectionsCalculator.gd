class_name ConnectionsCalculator

static func generate_connections(
	coordinates: Coordinates,
	coordinatesArray: Array,
	field_width: int,
	field_height: int
) -> CardinalConnections:
	var directions = []
	if _check_direction(
		coordinates,
		coordinatesArray,
		field_width,
		field_height,
		Direction.UP()
	):
		directions.push_back(Direction.UP())
	if _check_direction(
		coordinates,
		coordinatesArray,
		field_width,
		field_height,
		Direction.RIGHT()
	):
		directions.push_back(Direction.RIGHT())
	if _check_direction(
		coordinates,
		coordinatesArray,
		field_width,
		field_height,
		Direction.DOWN()
	):
		directions.push_back(Direction.DOWN())
	if _check_direction(
		coordinates,
		coordinatesArray,
		field_width,
		field_height,
		Direction.LEFT()
	):
		directions.push_back(Direction.LEFT())
	return CardinalConnections.new(directions)

static func _check_direction(
	coordinates: Coordinates,
	coordinatesArray: Array,
	field_width: int,
	field_height: int,
	direction: int
) -> bool:
	var dX = 0
	var dY = 0
	if direction == Direction.UP(): dY = -1
	elif direction == Direction.RIGHT(): dX = 1
	elif direction == Direction.DOWN(): dY = 1
	else: dX = -1
	var x = coordinates.get_x() + dX
	var y = coordinates.get_y() + dY
	return (
		_is_inside_field(x, y, field_width, field_height) &&
		_coordinates_exists(x, y, coordinatesArray)
	)

static func _is_inside_field(
	x: int,
	y: int,
	field_width: int,
	field_height: int
) -> bool:
	return (
		x >= 0 && x < field_width &&
		y >= 0 && y < field_height
	)

static func _coordinates_exists(
	x: int,
	y: int,
	coordinatesArray: Array
) -> bool:
	for c in coordinatesArray:
		if x == c.get_x() && y == c.get_y(): return true
	return false
