extends Node

# --- preloads ---
const Snake = preload("res://src/game/snake/Snake.tscn")
const DirectionsEnum = preload("res://src/enums/DirectionsEnum.gd")
const DIRECTIONS = preload("res://src/enums/DirectionsEnum.gd").DIRECTIONS

# --- constants ---
const EDIBLES_SPAWN_ATTEMPT_FREQUENCY = 1

var rng = RandomNumberGenerator.new()
var _game_over = false
var _stage_description
var _visual_parameters
var _setup_completed
var _snake
var _movement_elapsed_seconds = 0
var _spawn_attempt_elapsed_seconds = 0
var _edibles = []
var _player_can_set_direction = true
var _cells
var _to_be_removed_queue = []

var _edible_builder: EdibleBuilder

# --- core functions ---
func setup(
	stage_description: StageDescription,
	visual_parameters: VisualParameters
):
	_stage_description = stage_description
	_visual_parameters = visual_parameters
	_init_cells()
	_setup_snake()
	_edible_builder = EdibleBuilder.new(
		_snake,
		self,
		_visual_parameters
	)
	_setup_completed = true

func _process(delta):
	if _setup_completed && !_game_over:
		_handle_movement_input()
		_handle_snake_movement(delta)
		_handle_to_be_removed_queue_clear()
		_handle_edibles_spawn(delta)

func remove_edible(edible):
	_edibles.erase(edible)
	if edible != null:
		_to_be_removed_queue.push_back(edible)

func set_game_over(status):
	_game_over = status

# --- private setup functions ---

func _init_cells():
	_cells = []
	for x in _stage_description.get_field_size().get_width():
		for y in _stage_description.get_field_size().get_height():
			_cells.push_back(ImmutablePoint.new(x, y))

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
	if _movement_elapsed_seconds >= current_delta_seconds:
		_player_can_set_direction = true
		_movement_elapsed_seconds -= current_delta_seconds
		_snake.move(_visual_parameters.get_cell_pixels_size())

func _handle_to_be_removed_queue_clear():
	for r in _to_be_removed_queue:
		r.queue_free()
	_to_be_removed_queue.clear()

func _handle_edibles_spawn(delta: float):
	_spawn_attempt_elapsed_seconds += delta
	if _spawn_attempt_elapsed_seconds >= EDIBLES_SPAWN_ATTEMPT_FREQUENCY:
		_spawn_attempt_elapsed_seconds -= EDIBLES_SPAWN_ATTEMPT_FREQUENCY
		var free_cells = _get_free_cells()
		# instantaneous edibles spawn attempts
		for ir in _stage_description.get_instantaneous_edible_rules():
			if _can_spawn(ir, _edibles):
				var instance = _edible_builder \
					.build_new() \
					.set_rules(ir) \
					.set_free_cells(free_cells) \
					.build()
				if instance != null:
					free_cells.remove(free_cells.find(instance.get_placement()))
					_edibles.push_back(instance)
					add_child(instance)
	pass

func _can_spawn(
	rules,
	array: Array
) -> bool:
	return rng.randf() <= rules.get_spawn_probability() && _count_instances_by_type(array, rules.get_type()) < rules.get_max_instances()
		
func _count_instances_by_type(array: Array, type: String) -> int:
	var res = 0
	for e in array:
		if e.get_type() == type:
			res += 1
	return res

func _get_free_cells() -> Array:
	var res = _cells.duplicate(false)
	for s in _snake.get_body_points():
		# TODO snake's body parts and head should have their pre-calulated point
		var p = ImmutablePoint.new(
			s.get_x() / _visual_parameters.get_cell_pixels_size(),
			s.get_y() / _visual_parameters.get_cell_pixels_size()
		)
		var i = ImmutablePoint.get_point_index_in_array(res, p)
		if i != -1:
			res.pop_at(i)
	for e in _edibles:
		var i = ImmutablePoint.get_point_index_in_array(res, e.get_placement())
		if i != -1:
			res.pop_at(i)
	return res