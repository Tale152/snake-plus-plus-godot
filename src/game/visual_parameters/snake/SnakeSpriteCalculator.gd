class_name SnakeSpriteCalculator

static func get_body_or_tail_sprite(
	snake,
	visual_parameters: VisualParameters,
	placement: Placement
) -> AnimatedSprite:
	if(placement.get_previous_direction() == -1):
		# is tail
		if snake.get_properties().get_current_length() > 2:
			# base tail case: snake's length > 2
			return visual_parameters.get_tail_sprite(
				placement.get_next_direction()
			)
		else:
			# special tail case: snake's length == 2
			return visual_parameters.get_tail_sprite(
				snake.get_head().get_placement().get_next_direction()
			)
	else:
		# is body
		return visual_parameters.get_body_sprite(
			placement.get_next_direction(),
			placement.get_previous_direction()
		)
