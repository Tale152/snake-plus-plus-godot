class_name SnakeUnitView extends Area2D

var _sprite: AnimatedSprite

func _init(
	visual_parameters: VisualParameters,
	snake_unit_placement: SnakeUnitPlacement
):
	position = PositionCalculator.calculate_position(
		snake_unit_placement.get_coordinates(),
		visual_parameters.get_cell_pixels_size(),
		visual_parameters.get_game_pixels_offset()
	)
	_calculate_and_add_sprite(visual_parameters, snake_unit_placement)

func _calculate_and_add_sprite(
	visual_parameters: VisualParameters,
	placement: SnakeUnitPlacement
) -> void:
	if(placement.is_head()):
		_sprite = visual_parameters.get_head_sprite(
			placement.get_next_direction(),
			placement.get_previous_direction() == -1 # is also tail?
		)
	# TODO rest of body
	self.add_child(_sprite)

func play_sprite_animation(speed_scale: float) -> void:
	_sprite.speed_scale = speed_scale
	_sprite.play()

func stop_sprite_animation() -> void:
	_sprite.stop()
