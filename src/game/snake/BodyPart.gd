class_name BodyPart extends Area2D

var _placement: Placement
var _snake
var _game
var _visual_parameters: VisualParameters
var _sprite
var _px: int
var _offset: int

func _init(starting_placement: Placement, snake, game):
	_snake = snake
	_game = game
	_placement = starting_placement
	_visual_parameters = _game.get_visual_parameters()
	_px = _visual_parameters.get_cell_pixels_size()
	_offset = int(float(_px) / 2)
	move_to_placement()

func move_to_placement():
	position = Vector2(
		_placement.get_coordinates().get_x() * _px,
		_placement.get_coordinates().get_y() * _px
	)
	var sprite_tmp
	if(_placement.get_previous_direction() == -1):
		sprite_tmp = _visual_parameters \
			.get_tail_sprite(_placement.get_next_direction())
	else:
		sprite_tmp = _visual_parameters \
			.get_body_sprite(
				_placement.get_next_direction(),
				_placement.get_previous_direction()
			)
	sprite_tmp.set_offset(Vector2(_offset, _offset))
	if _sprite != null:
		remove_child(_sprite)
	_sprite = sprite_tmp
	self.add_child(_sprite)

func on_snake_head_collision():
	_game.set_game_over(true)

func play_sprite_animation(speed_scale):
	_sprite.speed_scale = speed_scale
	_sprite.play()

func get_placement() -> Placement:
	return _placement

func set_placement(p: Placement) -> void:
	_placement = p
