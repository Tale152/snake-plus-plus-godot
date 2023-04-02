class_name SnakeHead extends Area2D

var _placement: SnakeUnitPlacement
var _visual_parameters: VisualParameters
var _px: int
var _offset: Vector2
var _stage_description: StageDescription
var _sprite: AnimatedSprite

func _init(game):
	_visual_parameters = game.get_visual_parameters()
	_stage_description = game.get_stage_description()
	_px = _visual_parameters.get_cell_pixels_size()
	_offset = _visual_parameters.get_game_pixels_offset()
	_placement = SnakeUnitPlacement.new(
		_stage_description.get_snake_spawn_point(),
		_stage_description.get_snake_initial_direction(),
		-1 # snake starts being composed only by a head
	)
	update_position_on_screen()
	_calculate_and_render_new_sprite()

func get_placement() -> SnakeUnitPlacement:
	return _placement

func set_placement(placement: SnakeUnitPlacement) -> void:
	_placement = placement

func update_position_on_screen() -> void:
	position = PositionCalculator.calculate_position(
		_placement.get_coordinates(), _px, _offset
	)
	
func update_sprite() -> void:
	remove_child(_sprite)
	_calculate_and_render_new_sprite()

func _calculate_and_render_new_sprite() -> void:
	var new_sprite: AnimatedSprite = _visual_parameters.get_head_sprite(
		_placement.get_next_direction(),
		_placement.get_previous_direction() == -1 # is tail?
	)
	_sprite = new_sprite
	self.add_child(_sprite)

func play_sprite_animation(speed_scale: float) -> void:
	_sprite.speed_scale = speed_scale
	_sprite.play()

func stop_sprite_animation() -> void:
	_sprite.stop()
