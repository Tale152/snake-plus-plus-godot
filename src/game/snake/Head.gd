extends Area2D

const Game = preload("res://src/game/Game.gd")

var _placement: Placement
var _visual_parameters: VisualParameters
var _px: int
var _stage_description: StageDescription
var _sprite: AnimatedSprite

func initialize(game: Game):
	_visual_parameters = game.get_visual_parameters()
	_stage_description = game.get_stage_description()
	_px = _visual_parameters.get_cell_pixels_size()
	move_to(Placement.new(
		_stage_description.get_snake_spawn_point(),
		_stage_description.get_snake_initial_direction(),
		-1
	))
	
func move_to(new_placement: Placement):
	_placement = new_placement
	position = Vector2(
		new_placement.get_coordinates().get_x() * _px,
		new_placement.get_coordinates().get_y() * _px
	)
	_set_sprite()

func play_sprite_animation(speed_scale: float):
	_sprite.speed_scale = speed_scale
	_sprite.play()

func get_placement() -> Placement:
	return _placement

func _set_sprite():
	var sprite_tmp = _visual_parameters \
		.get_head_sprite(
			_placement.get_next_direction(),
			_placement.get_previous_direction() == -1 # is tail?
		)
	sprite_tmp.set_offset(Vector2(_px / 2, _px / 2))
	if _sprite != null:
		remove_child(_sprite)
	_sprite = sprite_tmp
	self.add_child(_sprite)
