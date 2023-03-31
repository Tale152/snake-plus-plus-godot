class_name GameModelBuilder extends Reference

var _width: int
var _height: int
var _snake_head: SnakeBodyPartTODO
var _perk_types: Array
var _walls: Array
var _initial_direction: int

func set_width(widht: int) -> GameModelBuilder:
	_width = widht
	return self

func set_height(height: int) -> GameModelBuilder:
	_height = height
	return self

func set_snake_head(snake_head: SnakeBodyPartTODO) -> GameModelBuilder:
	_snake_head = snake_head
	return self

func set_perk_types(perk_types: Array) -> GameModelBuilder:
	_perk_types = perk_types
	return self

func set_walls(walls: Array) -> GameModelBuilder:
	_walls = walls
	return self

func set_initial_direction(initial_direction: int) -> GameModelBuilder:
	_initial_direction = initial_direction
	return self

func build() -> GameModel:
	return GameModel.new(
		_width,
		_height,
		_snake_head,
		_perk_types,
		_walls,
		_initial_direction
	)
