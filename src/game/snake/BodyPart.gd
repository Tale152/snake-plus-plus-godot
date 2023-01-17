extends Area2D

signal snake_head_collision(collidable)

const DirectionsEnum = preload("res://src/enums/DirectionsEnum.gd")

const BODY_DIAGONAL_ANIMATION = "body_diagonal"
const BODY_STRAIGHT_UP_ANIMATION = "body_straight_up"
const BODY_STRAIGHT_RIGHT_ANIMATION = "body_straight_right"
const TAIL_UP_ANIMATION = "tail_up"
const TAIL_RIGHT_ANIMATION = "tail_right"

var placement
var s
var e

func spawn(starting_placement, snake, engine):
	self.connect("snake_head_collision", snake, "on_collision")
	s = snake
	e = engine
	move_to(starting_placement)

func move_to(new_placement):
	placement = new_placement
	position = new_placement.coordinates
	set_sprite()

func set_sprite():
	if(placement.previous_direction == null):
		set_tail_sprite()
	elif DirectionsEnum.are_opposite(placement.next_direction, placement.previous_direction):
		set_body_straight_sprite()
	elif DirectionsEnum.are_diagonal(placement.next_direction, placement.previous_direction):
		set_body_diagonal_sprite()
	else:
		push_error(
			"A body part cannot be neither opposite nor diagonal compared to the next body part"
		)

func set_tail_sprite():
	set_single_direction_body_sprite(
		TAIL_UP_ANIMATION,
		TAIL_RIGHT_ANIMATION
	)

func set_body_straight_sprite():
	set_single_direction_body_sprite(
		BODY_STRAIGHT_UP_ANIMATION,
		BODY_STRAIGHT_RIGHT_ANIMATION
	)

func set_single_direction_body_sprite(up_sprite, right_sprite):
	match placement.next_direction:
		DirectionsEnum.DIRECTIONS.UP:
			set_animated_sprite(up_sprite, false, false)
		DirectionsEnum.DIRECTIONS.DOWN:
			set_animated_sprite(up_sprite, true, false)
		DirectionsEnum.DIRECTIONS.RIGHT:
			set_animated_sprite(right_sprite, false, false)
		DirectionsEnum.DIRECTIONS.LEFT:
			set_animated_sprite(right_sprite, false, true)

func set_body_diagonal_sprite():
	var flip_v = (placement.next_direction == DirectionsEnum.DIRECTIONS.DOWN) || (placement.previous_direction == DirectionsEnum.DIRECTIONS.DOWN)
	var flip_h = (placement.next_direction == DirectionsEnum.DIRECTIONS.LEFT) || (placement.previous_direction == DirectionsEnum.DIRECTIONS.LEFT)
	set_animated_sprite(BODY_DIAGONAL_ANIMATION, flip_v, flip_h)

func set_animated_sprite(animation, flip_v, flip_h):
	$AnimatedSprite.animation = animation
	$AnimatedSprite.flip_v = flip_v
	$AnimatedSprite.flip_h = flip_h


func _on_BodyPart_area_entered(area):
	if area == s.get_node("Head"):
		emit_signal("snake_head_collision", self)

func on_snake_head_collision():
	e.set_game_over(true)
