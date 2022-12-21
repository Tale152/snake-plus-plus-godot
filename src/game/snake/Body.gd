extends Area2D

const DirectionsEnum = preload("res://src/enums/DirectionsEnum.gd")

const BODY_DIAGONAL_ANIMATION = "body_diagonal"
const BODY_STRAIGHT_UP_ANIMATION = "body_straight_up"
const BODY_STRAIGHT_RIGHT_ANIMATION = "body_straight_right"
const TAIL_UP_ANIMATION = "tail_up"
const TAIL_RIGHT_ANIMATION = "tail_right"

func spawn(starting_position, direction, next_body_placement):
	move(starting_position, direction, next_body_placement)

func move(starting_position, direction, next_body_placement):
	position = starting_position
	set_sprite(direction, next_body_placement)

func set_sprite(direction, next_body_placement):
	if(next_body_placement == null):
		set_tail_sprite(direction)
	elif DirectionsEnum.are_opposite(direction, next_body_placement):
		set_body_straight_sprite(direction)
	elif DirectionsEnum.are_diagonal(direction, next_body_placement):
		set_body_diagonal_sprite(direction, next_body_placement)
	else:
		push_error(
			"A body part cannot be neither opposite nor diagonal compared to the next body part"
		)

func set_tail_sprite(direction):
	set_single_direction_body_sprite(
		direction,
		TAIL_UP_ANIMATION,
		TAIL_RIGHT_ANIMATION
	)

func set_body_straight_sprite(direction):
	set_single_direction_body_sprite(
		direction,
		BODY_STRAIGHT_UP_ANIMATION,
		BODY_STRAIGHT_RIGHT_ANIMATION
	)

func set_single_direction_body_sprite(direction, up_sprite, right_sprite):
	match direction:
		DirectionsEnum.DIRECTIONS.UP:
			set_animated_sprite(up_sprite, false, false)
		DirectionsEnum.DIRECTIONS.DOWN:
			set_animated_sprite(up_sprite, true, false)
		DirectionsEnum.DIRECTIONS.RIGHT:
			set_animated_sprite(right_sprite, false, false)
		DirectionsEnum.DIRECTIONS.LEFT:
			set_animated_sprite(right_sprite, false, true)

func set_body_diagonal_sprite(direction, next_body_placement):
	set_animated_sprite(
		BODY_DIAGONAL_ANIMATION,
		direction == DirectionsEnum.DIRECTIONS.DOWN,
		next_body_placement == DirectionsEnum.DIRECTIONS.LEFT
	)

func set_animated_sprite(animation, flip_v, flip_h):
	$AnimatedSprite.animation = animation
	$AnimatedSprite.flip_v = flip_v
	$AnimatedSprite.flip_h = flip_h
