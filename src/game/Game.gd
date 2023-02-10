class_name Game extends Node

# --- constants ---
const EDIBLES_SPAWN_ATTEMPT_FREQUENCY = 1

var rng = RandomNumberGenerator.new()
var _invoker
var _game_over: bool = false
var _player: Player = Player.new()
var _next_direction: int = -1
var _next_next_direction: int = -1
var _stage_description: StageDescription
var _visual_parameters: VisualParameters
var _snake
var _snake_properties: SnakeProperties
var _snake_head: SnakeHead
var _movement_elapsed_seconds: float = 0
var _spawn_attempt_elapsed_seconds: float = 0
var _current_snake_delta_seconds: float
var _edibles: Dictionary
var _cells: Array
var _to_be_removed_queue: Array = []
var _background_cells: Array
var _elapsed_seconds: float

var _edible_builder: EdibleBuilder

func initialize(
	invoker,
	stage_description: StageDescription,
	visual_parameters: VisualParameters
):
	_invoker = invoker
	_stage_description = stage_description
	_visual_parameters = visual_parameters
	for r in _stage_description.get_instantaneous_edible_rules():
		_edibles[r.get_type()] = []
	_set_background()
	_init_cells()
	_setup_snake()
	_edible_builder = EdibleBuilder.new(_snake, self)
	_elapsed_seconds = 0

func tick(delta: float) -> void:
	_elapsed_seconds += delta
	_update_hud()
	_handle_snake_movement(delta)
	_handle_to_be_removed_queue_clear()
	_handle_edibles_spawn(delta)

func direction_input(input: int) -> void:
	if _next_direction == -1:
		if _compatible_movement_input(_snake_properties.get_current_direction(), input):
			_next_direction = input
	elif _next_next_direction == -1 && _movement_elapsed_seconds > (_current_snake_delta_seconds * 0.66):
		if _compatible_movement_input(_next_direction, input):
			_next_next_direction = input

func remove_edible(edible: Edible) -> void:
	_edibles[edible.get_type()].erase(edible)
	_to_be_removed_queue.push_back(edible)

func set_game_over(status) -> void:
	_game_over = status
	if _game_over:
		_snake_head.stop_sprite_animation()
		for b in _snake.get_body_parts():
			b.stop_sprite_animation()
		for cell in _background_cells:
			cell.stop_sprite_animation()
		for type in _edibles.keys():
			for e in _edibles[type]:
				e.stop_sprite_animation()

func is_game_over() -> bool:
	return _game_over

func get_stage_description() -> StageDescription:
	return _stage_description

func get_visual_parameters() -> VisualParameters:
	return _visual_parameters

func get_player() -> Player:
	return _player

# --- private setup functions ---

func _set_background() -> void:
	_background_cells = BackgroundGenerator.create_background_cells(
		_stage_description, _visual_parameters
	)
	for c in _background_cells:
		add_child(c)
		c.play_sprite_animation(0.3)

func _init_cells() -> void:
	_cells = []
	for x in _stage_description.get_field_size().get_width():
		for y in _stage_description.get_field_size().get_height():
			_cells.push_back(ImmutablePoint.new(x, y))

func _setup_snake() -> void:
	_snake = Snake.new(self)
	_snake_properties = _snake.get_properties()
	_snake_head = _snake.get_head()
	_current_snake_delta_seconds = _calculate_snake_current_delta_seconds()
	add_child(_snake)

# --- private process functions ---

func _compatible_movement_input(
	current_direction: int,
	input_direction: int
) -> bool:
	return (
		current_direction != input_direction &&
		current_direction != Directions.get_opposite(input_direction)
	)

func _handle_snake_movement(delta: float) -> void:
	_movement_elapsed_seconds += delta
	_current_snake_delta_seconds = _calculate_snake_current_delta_seconds()
	if _movement_elapsed_seconds >= _current_snake_delta_seconds:
		if _next_direction != -1:
			_snake_properties.set_current_direction(_next_direction)
			_next_direction = _next_next_direction
			_next_next_direction = -1
		_movement_elapsed_seconds -= _current_snake_delta_seconds
		_snake.move(_current_snake_delta_seconds)
		_handle_snake_collision()

func _calculate_snake_current_delta_seconds() -> float:
	var current_delta_seconds = _stage_description.get_snake_base_delta_seconds()
	var speedup_factor = _stage_description.get_snake_speedup_factor()
	for i in _snake_properties.get_current_length() - 1:
		current_delta_seconds *= speedup_factor
	return current_delta_seconds

func _handle_snake_collision() -> void:
	var head_coordinates: ImmutablePoint = _snake_head.get_placement().get_coordinates()
	var body_parts = _snake.get_body_parts()
	for b in body_parts:
		if head_coordinates.equals_to(b.get_placement().get_coordinates()):
			b.on_snake_head_collision()
	if !_game_over:
		# copying the edibles dictionary since after head collision maybe
		# an edible is removed from the array associated with the key
		var edibles_copy = _edibles.duplicate(true)
		for type in edibles_copy.keys():
			for e in edibles_copy[type]:
				if head_coordinates.equals_to(e.get_coordinates()):
					e.on_snake_head_collision()

func _handle_to_be_removed_queue_clear() -> void:
	for r in _to_be_removed_queue: r.queue_free()
	_to_be_removed_queue.clear()

func _handle_edibles_spawn(delta: float) -> void:
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
				if instance != null: # is is possible that no compatible free cell is found
					free_cells.remove(free_cells.find(instance.get_coordinates()))
					_edibles[ir.get_type()].push_back(instance)
					add_child(instance)

func _can_spawn(rules: EdibleRules, edibles_dictionary: Dictionary) -> bool:
	return (
		edibles_dictionary[rules.get_type()].size() < rules.get_max_instances()
		&& rng.randf() <= rules.get_spawn_probability()
	)

func _get_free_cells() -> Array:
	var res = _cells.duplicate(false)
	res.pop_at(ImmutablePoint.get_point_index_in_array(
		res, _snake_head.get_placement().get_coordinates()
	))
	for b in _snake.get_body_parts():
		var i = ImmutablePoint.get_point_index_in_array(res, b.get_placement().get_coordinates())
		if i != -1:
			res.pop_at(i)
	for type in _edibles.keys():
		for e in _edibles[type]:
			var i = ImmutablePoint.get_point_index_in_array(res, e.get_coordinates())
			if i != -1:
				res.pop_at(i)
	return res

func _update_hud() -> void:
	$TopHud/PointsLabel.text = str(_player.get_points())
	_update_time_hud()

func _update_time_hud() -> void:
	var seconds = floor(_elapsed_seconds)
	if seconds < 60:
		$TopHud/TimeLabel.text = str(seconds)
	else:
		var minutes = floor(seconds / 60)
		seconds = seconds - minutes * 60
		$TopHud/TimeLabel.text = str(minutes, ":", seconds if seconds > 9 else str(0, seconds))


func _on_PauseButton_pressed():
	_invoker.change_pause_status()
