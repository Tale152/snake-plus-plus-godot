class_name BodyPart extends Area2D

var _placement: Placement
var _snake
var _game
var _visual_parameters: VisualParameters
var _sprite
var _px: int
var _offset

func _init(starting_placement: Placement, snake, game):
	_snake = snake
	_game = game
	_placement = starting_placement
	_visual_parameters = _game.get_visual_parameters()
	_px = _visual_parameters.get_cell_pixels_size()
	_offset = _visual_parameters.get_game_pixels_offset()
	move_to_placement()

func move_to_placement():
	position = Vector2(
		_placement.get_coordinates().get_x() * _px + _offset.x,
		_placement.get_coordinates().get_y() * _px + _offset.y
	)
	var sprite_tmp
	if(_placement.get_previous_direction() == -1): # is tail
		var tail_sprite_direction: int
		if _snake.get_properties().get_current_length() > 2:
			tail_sprite_direction = _placement.get_next_direction()
		else:
			# special case of snake with only head and tail
			tail_sprite_direction = _snake.get_head().get_placement().get_next_direction()
		sprite_tmp = _visual_parameters \
			.get_tail_sprite(tail_sprite_direction)
	else: # is body
		sprite_tmp = _visual_parameters \
			.get_body_sprite(
				_placement.get_next_direction(),
				_placement.get_previous_direction()
			)
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
