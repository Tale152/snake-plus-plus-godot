extends Node2D

const MoveSetEnum = preload("../../enums/MoveSetEnum.gd")

const SPRITE_SIZE = 16
const DELTA_SECONDS = 0.5
var movement_elapsed_seconds

const ACTION_MOVE_RIGHT = "move_right"
const ACTION_MOVE_LEFT = "move_left"
const ACTION_MOVE_UP = "move_up"
const ACTION_MOVE_DOWN = "move_down"
var current_direction

var is_also_tail #TODO to be replaced; use the number of body parts
var can_input_direction
var current_position
	
func _ready():
	init_variables()
	$Head.initialize(
		current_direction,
		current_position
	)

func _process(delta):
	manage_input()
	manage_movement(delta)

func on_collision(collidable):
	collidable.on_collision(self)

func init_variables():
	current_position = Vector2.ZERO
	current_direction = MoveSetEnum.MOVE_SET.RIGHT
	movement_elapsed_seconds = 0
	is_also_tail = true
	can_input_direction = true

func manage_input():
	if can_input_direction:
		if Input.is_action_pressed(ACTION_MOVE_RIGHT):
			set_current_direction(MoveSetEnum.MOVE_SET.RIGHT)
		if Input.is_action_pressed(ACTION_MOVE_LEFT):
			set_current_direction(MoveSetEnum.MOVE_SET.LEFT)
		if Input.is_action_pressed(ACTION_MOVE_DOWN):
			set_current_direction(MoveSetEnum.MOVE_SET.DOWN)
		if Input.is_action_pressed(ACTION_MOVE_UP):
			set_current_direction(MoveSetEnum.MOVE_SET.UP)

func set_current_direction(direction):
	current_direction = direction
	can_input_direction = false

func manage_movement(delta):
	movement_elapsed_seconds += delta
	if(movement_elapsed_seconds >= DELTA_SECONDS):
		movement_elapsed_seconds -= DELTA_SECONDS
		can_input_direction = true
		match current_direction:
			MoveSetEnum.MOVE_SET.RIGHT:
				current_position.x += SPRITE_SIZE
			MoveSetEnum.MOVE_SET.LEFT:
				current_position.x -= SPRITE_SIZE
			MoveSetEnum.MOVE_SET.UP:
				current_position.y -= SPRITE_SIZE
			MoveSetEnum.MOVE_SET.DOWN:
				current_position.y += SPRITE_SIZE
		$Head.move_to(current_direction, is_also_tail, current_position)
