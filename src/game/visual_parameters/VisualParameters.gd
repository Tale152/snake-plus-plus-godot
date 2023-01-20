class_name VisualParameters extends Reference

var _cell_pixels_size: int
var _edible_sprites: Array
var _body_sprites: Array
var _head_sprites: Array
var _tail_sprites: Array

func _init(
	cell_pixels_size: int,
	edible_sprites: Array,
	head_sprites: Array,
	body_sprites: Array,
	tail_sprites: Array
):
	_cell_pixels_size = cell_pixels_size
	_edible_sprites = edible_sprites
	_head_sprites = head_sprites
	_body_sprites = body_sprites
	_tail_sprites = tail_sprites

func get_cell_pixels_size() -> int:
	return _cell_pixels_size

func get_edible_sprite(name: String) -> EdibleSprite:
	for s in _edible_sprites:
		if s.get_name() == name:
			return s.get_sprite()
	return null

func get_head_sprite(direction: int, is_tail: bool) -> SnakeHeadSprite:
	for h in _head_sprites:
		if h.is_tail() == is_tail && h.get_direction() == direction:
			return h
	return null

func get_body_sprite(traveling_direction: int, back_direction:int) -> SnakeBodySprite:
	for b in _body_sprites:
		if b.get_traveling_direction() == traveling_direction && b.get_back_direction() == back_direction:
			return b
	return null

func get_tail_sprite(direction: int) -> SnakeTailSprite:
	for t in _tail_sprites:
		if t.get_direction() == direction:
			return t
	return null
