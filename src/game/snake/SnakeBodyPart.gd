class_name SnakeBodyPart extends Area2D

var _placement: Placement
var _snake
var _game
var _visual_parameters: VisualParameters
var _sprite: AnimatedSprite
var _px: int
var _offset: Vector2

func _init(starting_placement: Placement, snake, game):
	_snake = snake
	_game = game
	_placement = starting_placement
	_visual_parameters = _game.get_visual_parameters()
	_px = _visual_parameters.get_cell_pixels_size()
	_offset = _visual_parameters.get_game_pixels_offset()
	update_position_on_screen()
	update_sprite()

func get_placement() -> Placement:
	return _placement

func set_placement(p: Placement) -> void:
	_placement = p
	
func update_position_on_screen() -> void:
	position = PositionCalculator.calculate_position(
		_placement.get_coordinates(), _px, _offset
	)

func update_sprite() -> void:
	var new_sprite: AnimatedSprite = SnakeSpriteCalculator \
		.get_body_or_tail_sprite(_snake, _visual_parameters, _placement)
	if _sprite != null:
		remove_child(_sprite)
	_sprite = new_sprite
	self.add_child(_sprite)

func play_sprite_animation(speed_scale: float) -> void:
	_sprite.speed_scale = speed_scale
	_sprite.play()

func stop_sprite_animation() -> void:
	_sprite.stop()
	
func on_snake_head_collision():
	_game.set_game_over(true)
