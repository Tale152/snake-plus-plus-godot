extends Area2D

var _placement: Placement
var _visual_parameters: VisualParameters
var _px: int
var _offset: int
var _stage_description: StageDescription
var _sprite: AnimatedSprite

func initialize(game):
	_visual_parameters = game.get_visual_parameters()
	_stage_description = game.get_stage_description()
	_px = _visual_parameters.get_cell_pixels_size()
	_offset = int(float(_px) / 2)
	_placement = Placement.new(
		_stage_description.get_snake_spawn_point(),
		_stage_description.get_snake_initial_direction(),
		-1
	)
	move_to_placement()
	
func move_to_placement() -> void:
	position = Vector2(
		_placement.get_coordinates().get_x() * _px,
		_placement.get_coordinates().get_y() * _px
	)
	_set_sprite()

func play_sprite_animation(speed_scale: float):
	_sprite.speed_scale = speed_scale
	_sprite.play()

func get_placement() -> Placement:
	return _placement

func set_placement(p: Placement) -> void:
	_placement = p

func _set_sprite():
	var sprite_tmp = _visual_parameters \
		.get_head_sprite(
			_placement.get_next_direction(),
			_placement.get_previous_direction() == -1 # is tail?
		)
	sprite_tmp.set_offset(Vector2(_offset, _offset))
	if _sprite != null:
		remove_child(_sprite)
	_sprite = sprite_tmp
	self.add_child(_sprite)
