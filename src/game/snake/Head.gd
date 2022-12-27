extends Area2D

const DirectionsEnum = preload("res://src/enums/DirectionsEnum.gd")

const HEAD_UP_ANIMATION = "head_up"
const HEAD_RIGHT_ANIMATION = "head_right"
const HEAD_TAIL_UP_ANIMATION = "head_tail_up"
const HEAD_TAIL_RIGHT_ANIMATION = "head_tail_right"

var placement

func initialize(starting_placement):
	move_to(starting_placement)
	
func move_to(new_placement):
	placement = new_placement
	position = placement.coordinates
	_set_sprite()

func _set_sprite():
	match placement.next_direction:
		DirectionsEnum.DIRECTIONS.UP:
			_set_head_sprite_vertical(false)
		DirectionsEnum.DIRECTIONS.DOWN:
			_set_head_sprite_vertical(true)
		DirectionsEnum.DIRECTIONS.RIGHT:
			_set_head_sprite_horizontal(false)
		DirectionsEnum.DIRECTIONS.LEFT:
			_set_head_sprite_horizontal(true)

func _set_head_sprite_horizontal(is_going_left):
	_set_animated_sprite(
		HEAD_TAIL_RIGHT_ANIMATION if placement.previous_direction == null else HEAD_RIGHT_ANIMATION,
		false,
		is_going_left
	)

func _set_head_sprite_vertical(is_going_down):
	_set_animated_sprite(
		HEAD_TAIL_UP_ANIMATION if placement.previous_direction == null else HEAD_UP_ANIMATION,
		is_going_down,
		false
	)

func _set_animated_sprite(animation, flip_v, flip_h):
	$AnimatedSprite.animation = animation
	$AnimatedSprite.flip_v = flip_v
	$AnimatedSprite.flip_h = flip_h
