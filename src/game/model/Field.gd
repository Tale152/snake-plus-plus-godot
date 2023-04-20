class_name Field extends Reference

var _width: int
var _width_range: Array
var _height: int
var _height_range: Array
var _cells: Array = []
var _perks: Dictionary = {}
var _walls: Array = []
var _snake_body_parts: Array = []

func _init(
	width: int,
	height: int,
	snake_head: SnakeBodyPart,
	perk_types: Array,
	walls: Array
):
	_width = width
	_width_range = range(0, _width)
	_height = height
	_height_range = range(0, _height)
	for perk_type in perk_types: _perks[perk_type] = []
	for x in _width_range:
		_cells.push_back([])
		for y in _height_range:
			_cells[x].push_back([Coordinates.new(x, y), []])
	for wall in walls:
		_walls.push_back(wall)
		_push_back_collidable_in_cells(wall)
	_snake_body_parts.push_back(snake_head)
	_push_back_collidable_in_cells(snake_head)

func get_width() -> int:
	return _width

func get_height() -> int:
	return _height

func get_at(coord: Coordinates) -> Array:
	return _copy_array(_cells[coord.get_x()][coord.get_y()][1])

func is_coordinate_empty(coord: Coordinates) -> bool:
	return _cells[coord.get_x()][coord.get_y()][1].size() == 0

func get_empty_coordinates(current_direction: int) -> Array:
	var sides: Array = Direction.get_sides(current_direction);
	var current_direction_coord: Coordinates = get_coord_from_head(
		current_direction
	)
	var side1: Coordinates = get_coord_from_head(sides[0])
	var side2: Coordinates = get_coord_from_head(sides[1])
	var res: Array = []
	for x in _width_range:
		var height_array: Array = _cells[x]
		if x == current_direction_coord.get_x() || x == side1.get_x() || x == side2.get_x():
			for y in _height_range:
				var cell: Array = height_array[y]
				var coord: Coordinates = cell[0]
				if (
					cell[1].size() == 0 && 
					!(
						current_direction_coord.equals_to(coord) ||
						side1.equals_to(coord) ||
						side2.equals_to(coord)
					)
				): res.push_back(coord)
		else:
			for y in _height_range:
				var cell: Array = height_array[y]
				if cell[1].size() == 0: res.push_back(cell[0])
	return res

func get_coord_from_head(direction: int) -> Coordinates:
	var head: Coordinates = _snake_body_parts[0].get_coordinates()
	if direction == Direction.UP():
		var y = head.get_y() - 1
		if y < 0: y = _height - 1
		return _cells[head.get_x()][y][0]
	elif direction == Direction.RIGHT():
		var x = head.get_x() + 1
		if x == _width: x = 0
		return _cells[x][head.get_y()][0]
	elif direction == Direction.DOWN():
		var y = head.get_y() + 1
		if y == _height: y = 0
		return _cells[head.get_x()][y][0]
	else:
		var x = head.get_x() - 1
		if x < 0: x = _width - 1
		return _cells[x][head.get_y()][0]

func add_perk(perk: Perk) -> void:
	_perks[perk.get_perk_type()].push_back(perk)
	_push_back_collidable_in_cells(perk)

func remove_perk(perk: Perk) -> void:
	_perks[perk.get_perk_type()].erase(perk)
	var coord: Coordinates = perk.get_coordinates()
	_cells[coord.get_x()][coord.get_y()][1].erase(perk)

func get_perks() -> Dictionary:
	var res: Dictionary = {}
	for perk_type in _perks.keys():
		res[perk_type] = _copy_array(_perks[perk_type])
	return res

func count_perks_by_type(perk_type: int) -> int:
	return _perks[perk_type].size()

func get_walls() -> Array:
	return _copy_array(_walls)

func get_snake_body_parts() -> Array:
	return _copy_array(_snake_body_parts)

func set_snake_body_parts(body_parts: Array) -> void:
	for bp in _snake_body_parts:
		var coord: Coordinates = bp.get_coordinates()
		_cells[coord.get_x()][coord.get_y()][1].erase(bp)
	_snake_body_parts = body_parts
	var i = _snake_body_parts.size() - 1
	while(i > -1):
		_push_back_collidable_in_cells(_snake_body_parts[i])
		i -= 1

func _push_back_collidable_in_cells(collidable: CollidableEntity) -> void:
	var coord = collidable.get_coordinates()
	_cells[coord.get_x()][coord.get_y()][1].push_back(collidable)

func _copy_array(arr: Array) -> Array:
	var res: Array = []
	for element in arr: res.push_back(element)
	return res
