class_name FreeCellsHandler extends Reference

var _cells: Array = []
var _snake: Snake
var _snake_head: SnakeHead

func _init(field_size: FieldSize, snake: Snake):
	for x in field_size.get_width():
		for y in field_size.get_height():
			_cells.push_back(ImmutablePoint.new(x, y))
	_snake = snake
	_snake_head = snake.get_head()

func get_free_cells(walls: Array, edibles: Dictionary) -> Array:
	var res = _cells.duplicate(false)
	for w in walls:
		w.get_coordinates().remove_from_array(res)
	_snake_head.get_placement().get_coordinates().remove_from_array(res)
	for b in _snake.get_body_parts():
		b.get_placement().get_coordinates().remove_from_array(res)
	for type in edibles.keys():
		for e in edibles[type]:
			e.get_coordinates().remove_from_array(res)
	return res
