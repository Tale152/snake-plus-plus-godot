extends Node

const FIELD_CELLS_WIDTH = 20
const FIELD_CELLS_HEIGHT = 10
const CELL_SIZE = 16

const APPLE = preload("res://src/game/edibles/Apple.tscn")
const DIRECTIONS = preload("res://src/enums/DirectionsEnum.gd").DIRECTIONS

const BASE_DELTA_SECONDS = 0.5
const SPEEDUP_FACTOR = 0.98
var movement_elapsed_seconds
var can_set_direction

const ACTION_MOVE_RIGHT = "move_right"
const ACTION_MOVE_LEFT = "move_left"
const ACTION_MOVE_UP = "move_up"
const ACTION_MOVE_DOWN = "move_down"

const EDIBLE_SPAWN_DELTA_SECONDS = 1
var edible_spawn_elapsed_seconds
const EDIBLE_SPAWN_PROBABILITY = 0.25

var edibles
var to_be_removed_queue

var rng = RandomNumberGenerator.new()

var game_over

func _ready():
	game_over = false
	rng.randomize()
	movement_elapsed_seconds = 0
	edible_spawn_elapsed_seconds = 0
	edibles = []
	to_be_removed_queue = []
	can_set_direction = true
	$Snake.initialize(
		DIRECTIONS.RIGHT,
		Vector2(0, 0),
		Vector2(FIELD_CELLS_WIDTH * CELL_SIZE, FIELD_CELLS_HEIGHT * CELL_SIZE),
		self
	)
	
func _process(delta):
	if !game_over:
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
		
		edible_spawn_elapsed_seconds += delta
		if(edible_spawn_elapsed_seconds >= EDIBLE_SPAWN_DELTA_SECONDS):
			edible_spawn_elapsed_seconds -= edible_spawn_elapsed_seconds
			var r = rng.randf()
			if r <= EDIBLE_SPAWN_PROBABILITY:
				var apple_instance = APPLE.instance()
				var found = false
				var spawn_position
				while !found:
					var x = (rng.randi()%FIELD_CELLS_WIDTH)*CELL_SIZE
					var y = (rng.randi()%FIELD_CELLS_HEIGHT)*CELL_SIZE
					spawn_position = Vector2(x, y)
					found = !is_overlapping(spawn_position, [$Snake.get_node("Head")]) && !is_overlapping(spawn_position, $Snake.body_parts) && !is_overlapping(spawn_position, edibles)
				add_child(apple_instance)
				apple_instance.spawn(spawn_position, $Snake, self)
				edibles.push_back(apple_instance)

func remove_edible(edible):
	edibles.erase(edible)
	if edible != null:
		to_be_removed_queue.push_back(edible)

func is_overlapping(position, nodes):
	for n in nodes:
		if n.position == position:
			return true
	return false

