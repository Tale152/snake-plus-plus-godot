extends Area2D

const DirectionsEnum = preload("../../enums/DirectionsEnum.gd")

const HEAD_UP_ANIMATION = "head_up"
const HEAD_RIGHT_ANIMATION = "head_right"
const HEAD_TAIL_UP_ANIMATION = "head_tail_up"
const HEAD_TAIL_RIGHT_ANIMATION = "head_tail_right"

func initialize(direction, starting_position):
	position = starting_position
	set_sprite(direction, true)
	
func move_to(direction, is_also_tail, new_position):
	position = new_position
	set_sprite(direction, is_also_tail)
	
func set_sprite(direction, is_also_tail):
	match direction:
		DirectionsEnum.DIRECTIONS.UP:
			set_head_sprite_vertical(is_also_tail, false)
		DirectionsEnum.DIRECTIONS.DOWN:
			set_head_sprite_vertical(is_also_tail, true)
		DirectionsEnum.DIRECTIONS.RIGHT:
			set_head_sprite_horizontal(is_also_tail, false)
		DirectionsEnum.DIRECTIONS.LEFT:
			set_head_sprite_horizontal(is_also_tail, true)
	
func set_head_sprite_horizontal(is_also_tail, is_going_left):
	set_animated_sprite(
		HEAD_TAIL_RIGHT_ANIMATION if is_also_tail else HEAD_RIGHT_ANIMATION,
		false,
		is_going_left
	)
	
func set_head_sprite_vertical(is_also_tail, is_going_down):
	set_animated_sprite(
		HEAD_TAIL_UP_ANIMATION if is_also_tail else HEAD_UP_ANIMATION,
		is_going_down,
		false
	)
	
func set_animated_sprite(animation, flip_v, flip_h):
	$AnimatedSprite.animation = animation
	$AnimatedSprite.flip_v = flip_v
	$AnimatedSprite.flip_h = flip_h
