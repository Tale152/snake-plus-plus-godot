class_name VisualParameters extends Reference

var _cell_pixels_size: int
var _game_pixels_offset: Vector2
var _perks_sprites: Array
var _body_sprites: Array
var _head_sprites: Array
var _tail_sprites: Array
var _background_sprites: Array
var _walls_sprites: Array

func _init(
	cell_pixels_size: int,
	game_pixels_offset: Vector2,
	perks_sprites: Array,
	head_sprites: Array,
	body_sprites: Array,
	tail_sprites: Array,
	background_sprites: Array,
	walls_sprites: Array
):
	_cell_pixels_size = cell_pixels_size
	_game_pixels_offset = game_pixels_offset
	_perks_sprites = perks_sprites
	_head_sprites = head_sprites
	_body_sprites = body_sprites
	_tail_sprites = tail_sprites
	_background_sprites = background_sprites
	_walls_sprites = walls_sprites

func get_cell_pixels_size() -> int:
	return _cell_pixels_size

func get_game_pixels_offset() -> Vector2:
	return _game_pixels_offset

func get_perk_sprite(name: String) -> AnimatedSprite:
	for s in _perks_sprites:
		if s.get_name() == name:
			return s.get_sprite().duplicate()
	return null

func get_head_sprite(direction: int, is_tail: bool) -> AnimatedSprite:
	for h in _head_sprites:
		if h.is_tail() == is_tail && h.get_direction() == direction:
			return h.get_sprite().duplicate()
	return null

func get_body_sprite(traveling_direction: int, back_direction:int) -> AnimatedSprite:
	for b in _body_sprites:
		if b.get_traveling_direction() == traveling_direction && b.get_back_direction() == back_direction:
			return b.get_sprite().duplicate()
	return null

func get_tail_sprite(direction: int) -> AnimatedSprite:
	for t in _tail_sprites:
		if t.get_direction() == direction:
			return t.get_sprite().duplicate()
	return null

func get_background_sprites() -> Array:
	var res = []
	for b in _background_sprites:
		res.push_back(b.get_sprite())
	return res;

func get_wall_sprite(cardinal_connections: CardinalConnections) -> AnimatedSprite:
	for ws in _walls_sprites:
		if ws.get_cardinal_connections().equals_to(cardinal_connections):
			return ws.get_sprite().duplicate()
	return null
