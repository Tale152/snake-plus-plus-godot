extends Node

const APPLE = preload("res://src/game/edibles/Apple.tscn")
const DIRECTIONS = preload("res://src/enums/DirectionsEnum.gd").DIRECTIONS

const DELTA_SECONDS = 0.5
var movement_elapsed_seconds
var can_set_direction

const ACTION_MOVE_RIGHT = "move_right"
const ACTION_MOVE_LEFT = "move_left"
const ACTION_MOVE_UP = "move_up"
const ACTION_MOVE_DOWN = "move_down"

func _ready():
	movement_elapsed_seconds = 0
	can_set_direction = true
	$Snake.initialize(DIRECTIONS.RIGHT, Vector2(0, 0), Vector2(320, 160))
	var apple_instance = APPLE.instance()
	add_child(apple_instance)
	apple_instance.spawn(Vector2(80, 0), $Snake)
	$Timer.start()
	
func _process(delta):
	if can_set_direction:
		if Input.is_action_pressed(ACTION_MOVE_RIGHT) && $Snake.properties.current_direction != DIRECTIONS.RIGHT && $Snake.properties.current_direction != DIRECTIONS.LEFT:
			can_set_direction = false
			$Snake.properties.current_direction = DIRECTIONS.RIGHT
		if Input.is_action_pressed(ACTION_MOVE_LEFT) && $Snake.properties.current_direction != DIRECTIONS.LEFT && $Snake.properties.current_direction != DIRECTIONS.RIGHT:
			can_set_direction = false
			$Snake.properties.current_direction = DIRECTIONS.LEFT
		if Input.is_action_pressed(ACTION_MOVE_DOWN) && $Snake.properties.current_direction != DIRECTIONS.DOWN && $Snake.properties.current_direction != DIRECTIONS.UP:
			can_set_direction = false
			$Snake.properties.current_direction = DIRECTIONS.DOWN
		if Input.is_action_pressed(ACTION_MOVE_UP) && $Snake.properties.current_direction != DIRECTIONS.UP && $Snake.properties.current_direction != DIRECTIONS.DOWN:
			can_set_direction = false
			$Snake.properties.current_direction = DIRECTIONS.UP
		
	movement_elapsed_seconds += delta
	if(movement_elapsed_seconds >= DELTA_SECONDS):
		can_set_direction = true
		movement_elapsed_seconds -= DELTA_SECONDS
		$Snake.move(16)

func _on_Timer_timeout():
	var apple_instance = APPLE.instance()
	add_child(apple_instance)
	var x = (randi()%20)*16
	var y = (randi()%10)*16
	apple_instance.spawn(Vector2(x, y), $Snake)

