extends Node

const APPLE = preload("res://src/game/edibles/Apple.tscn")
const DIRECTIONS = preload("res://src/enums/DirectionsEnum.gd").DIRECTIONS

const BASE_DELTA_SECONDS = 0.5
const SPEEDUP_FACTOR = 0.99
var movement_elapsed_seconds
var can_set_direction

const ACTION_MOVE_RIGHT = "move_right"
const ACTION_MOVE_LEFT = "move_left"
const ACTION_MOVE_UP = "move_up"
const ACTION_MOVE_DOWN = "move_down"

const CELL_SIZE = 16
var edibles
var to_be_removed_queue

func _ready():
	movement_elapsed_seconds = 0
	edibles = []
	to_be_removed_queue = []
	can_set_direction = true
	$Snake.initialize(DIRECTIONS.RIGHT, Vector2(0, 0), Vector2(320, 160))
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
	var current_delta_seconds = BASE_DELTA_SECONDS
	for i in $Snake.properties.current_length - 1:
		current_delta_seconds *= SPEEDUP_FACTOR
	if(movement_elapsed_seconds >= current_delta_seconds):
		can_set_direction = true
		movement_elapsed_seconds -= current_delta_seconds
		$Snake.move(CELL_SIZE)
		
	for r in to_be_removed_queue:
		r.queue_free()
	to_be_removed_queue.clear()

func _on_Timer_timeout():
	var apple_instance = APPLE.instance()
	add_child(apple_instance)
	var x = (randi()%20)*16
	var y = (randi()%10)*16
	apple_instance.spawn(Vector2(x, y), $Snake, self)
	edibles.push_back(apple_instance)
	
func remove_edible(edible):
	edibles.erase(edible)
	if edible != null:
		to_be_removed_queue.push_back(edible)

