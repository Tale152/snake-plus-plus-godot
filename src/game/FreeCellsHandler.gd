class_name FreeCellsHandler extends Reference

var _cells: Array = []
var _snake: Snake
var _snake_head: SnakeHead
var _field_width: int
var _field_heigth: int

func _init(field_size: FieldSize, snake: Snake):
	_field_width = field_size.get_width()
	_field_heigth = field_size.get_height()
	for x in _field_width:
		for y in _field_heigth:
			_cells.push_back(ImmutablePoint.new(x, y))
	_snake = snake
	_snake_head = snake.get_head()

func get_free_cells(walls: Array, edibles: Dictionary) -> Array:
	var res = _cells.duplicate(false)
	for w in walls:
		w.get_coordinates().remove_from_array(res)
	var head_coordinates = _snake_head.get_placement().get_coordinates()
	head_coordinates.remove_from_array(res)
	for b in _snake.get_body_parts():
		b.get_placement().get_coordinates().remove_from_array(res)
	for s in _get_surrounding_array(head_coordinates):
		s.remove_from_array(res)
	for type in edibles.keys():
		for e in edibles[type]:
			e.get_coordinates().remove_from_array(res)
	return res

func _get_surrounding_array(p: ImmutablePoint) -> Array:
	var res = []
	var old_x = p.get_x()
	var old_y = p.get_y()
	var left_new_x = old_x - 1
	if left_new_x < 0:
		res.push_back(ImmutablePoint.new(_field_width - 1, old_y))
		# If I'm on the left edge than right is inside field
		res.push_back(ImmutablePoint.new(old_x + 1, old_y)) 
	else:
		res.push_back(ImmutablePoint.new(left_new_x, old_y))
		var right_new_x = old_x + 1
		if right_new_x >= _field_width:
			res.push_back(ImmutablePoint.new(0, old_y))
		else:
			res.push_back(ImmutablePoint.new(right_new_x, old_y))
	var up_new_y = old_y - 1
	if up_new_y < 0:
		res.push_back(ImmutablePoint.new(old_x, _field_heigth - 1))
		# If I'm on the upper edge than down is inside field
		res.push_back(ImmutablePoint.new(old_x, old_y + 1)) 
	else:
		res.push_back(ImmutablePoint.new(old_x, up_new_y))
		var down_new_y = old_y + 1
		if down_new_y >= _field_heigth:
			res.push_back(ImmutablePoint.new(old_x, 0))
		else:
			res.push_back(ImmutablePoint.new(old_x, down_new_y))
	return res
