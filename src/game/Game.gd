extends Node

# --- preloads ---
const Snake = preload("res://src/game/snake/Snake.tscn")
const DirectionsEnum = preload("res://src/enums/DirectionsEnum.gd")
const DIRECTIONS = preload("res://src/enums/DirectionsEnum.gd").DIRECTIONS

var _stage_description
var _visual_parameters
var _setup_completed
var _snake
var _movement_elapsed_seconds
var _player_can_set_direction

# --- core functions ---
func setup(
	stage_description: StageDescription,
	visual_parameters: VisualParameters
):
	_stage_description = stage_description
	_visual_parameters = visual_parameters
	_setup_snake()
	_setup_snake_movement()
	_setup_completed = true

func _process(delta):
	if _setup_completed == true:
		_handle_movement_input()
		_handle_snake_movement(delta)

# --- private setup functions ---
func _setup_snake():
	_snake = Snake.instance()
	_snake.initialize(
		_stage_description.get_snake_initial_direction(),
		Vector2(0, 0),
		Vector2(
			_stage_description.get_field_size().get_width() * _visual_parameters.get_cell_pixels_size(),
			_stage_description.get_field_size().get_height() * _visual_parameters.get_cell_pixels_size()
		),
		self
	)
	add_child(_snake)

func _setup_snake_movement():
	_movement_elapsed_seconds = 0
	_player_can_set_direction = true

# --- private process functions ---
func _handle_movement_input():
	if _player_can_set_direction:
		if _compatible_movement_input(MovementInput.get_action_move_right(), DIRECTIONS.RIGHT):
			_set_new_snake_direction(DIRECTIONS.RIGHT)
		elif _compatible_movement_input(MovementInput.get_action_move_left(), DIRECTIONS.LEFT):
			_set_new_snake_direction(DIRECTIONS.LEFT)
		elif _compatible_movement_input(MovementInput.get_action_move_up(), DIRECTIONS.UP):
			_set_new_snake_direction(DIRECTIONS.UP)
		elif _compatible_movement_input(MovementInput.get_action_move_down(), DIRECTIONS.DOWN):
			_set_new_snake_direction(DIRECTIONS.DOWN)

func _compatible_movement_input(input: String, current_direction: int) -> bool:
	return (
		Input.is_action_pressed(input)
		&& _snake.properties.current_direction != current_direction
		&& _snake.properties.current_direction != DirectionsEnum.get_opposite(current_direction)
	)

func _set_new_snake_direction(direction:int):
	_player_can_set_direction = false
	_snake.properties.current_direction = direction

func _handle_snake_movement(delta: float):
	_movement_elapsed_seconds += delta
	var current_delta_seconds = _stage_description.get_snake_base_delta_seconds()
	for i in _snake.properties.current_length - 1:
		current_delta_seconds *= _stage_description.get_snake_speedup_factor()
	if(_movement_elapsed_seconds >= current_delta_seconds):
		_player_can_set_direction = true
		_movement_elapsed_seconds -= current_delta_seconds
		_snake.move(_visual_parameters.get_cell_pixels_size())
