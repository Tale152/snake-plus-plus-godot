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
	# called often (every snake movement), but typically 0 or 1 element (unless multiple snake body parts in it): can afford to use _copy_array
	# having a copy is also useful for the collision algorythm
	return _copy_array(_cells[coord.get_x()][coord.get_y()][1])

func is_coordinate_empty(coord: Coordinates) -> bool:
	return _cells[coord.get_x()][coord.get_y()][1].size() == 0

func get_empty_coordinates() -> Array:
	var res: Array = []
	for x in _width_range:
		var height_array: Array = _cells[x]
		for y in _height_range:
			var cell: Array = height_array[y]
			if cell[1].size() == 0: res.push_back(cell[0])
	return res

func add_perk(perk: Perk) -> void:
	_perks[perk.get_type()].push_back(perk)
	_push_back_collidable_in_cells(perk)

func remove_perk(perk: Perk) -> void:
	_perks[perk.get_type()].erase(perk)
	var coord = perk.get_coordinates()
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
	# called often (every snake movement) with a decent amount of element in it: cannot afford time to use _copy_array
	# since reference is returned, having a set_snake_body_parts is useless because every change is reflected also in _snake_body_parts
	return _snake_body_parts

func set_snake_body_parts(body_parts: Array) -> void:
	_snake_body_parts = body_parts

func _push_back_collidable_in_cells(collidable: CollidableEntity) -> void:
	var coord = collidable.get_coordinates()
	_cells[coord.get_x()][coord.get_y()][1].push_back(collidable)

func _copy_array(arr: Array) -> Array:
	var res: Array = []
	for element in arr: res.push_back(element)
	return res
