class_name Game extends Node

# --- constants ---
const EDIBLES_SPAWN_ATTEMPT_FREQUENCY = 1

var rng = RandomNumberGenerator.new()
var _game_over = false
var _stage_description: StageDescription
var _visual_parameters: VisualParameters
var _setup_completed
var _snake
var _movement_elapsed_seconds = 0
var _spawn_attempt_elapsed_seconds = 0
var _edibles = []
var _player_can_set_direction = true
var _cells
var _to_be_removed_queue = []

var _edible_builder: EdibleBuilder

func _init(
	stage_description: StageDescription,
	visual_parameters: VisualParameters
):
	_stage_description = stage_description
	_visual_parameters = visual_parameters
	_set_background()
	_init_cells()
	_setup_snake()
	_edible_builder = EdibleBuilder.new(
		_snake,
		self,
		_visual_parameters
	)
	_setup_completed = true

# --- core functions ---

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

func get_stage_description() -> StageDescription:
	return _stage_description

func get_visual_parameters() -> VisualParameters:
	return _visual_parameters

# --- private setup functions ---

func _set_background():
	var field_size = _stage_description.get_field_size()
	var sprites = _visual_parameters.get_background_sprites()
	var sprites_number = sprites.size()
	var px_size = _visual_parameters.get_cell_pixels_size()
	var rendered_sprites = []
	for x in range(0, field_size.get_width()):
		for y in range(0, field_size.get_height()):
			var b = Area2D.new()
			b.position = Vector2(px_size * x, px_size * y)
			var s = sprites[rng.randi() % sprites_number].duplicate()
			s.speed_scale = 0.3
			b.add_child(s)
			self.add_child(b)
			rendered_sprites.push_back(s)
	for rs in rendered_sprites:
		rs.play()

func _init_cells():
	_cells = []
	for x in _stage_description.get_field_size().get_width():
		for y in _stage_description.get_field_size().get_height():
			_cells.push_back(ImmutablePoint.new(x, y))

func _setup_snake():
	_snake = Snake.new(self)
	add_child(_snake)

# --- private process functions ---
func _handle_movement_input():
	if _player_can_set_direction:
		if _compatible_movement_input(MovementInput.get_action_move_right(), Directions.get_right()):
			_set_new_snake_direction(Directions.get_right())
		elif _compatible_movement_input(MovementInput.get_action_move_left(), Directions.get_left()):
			_set_new_snake_direction(Directions.get_left())
		elif _compatible_movement_input(MovementInput.get_action_move_up(), Directions.get_up()):
			_set_new_snake_direction(Directions.get_up())
		elif _compatible_movement_input(MovementInput.get_action_move_down(), Directions.get_down()):
			_set_new_snake_direction(Directions.get_down())

func _compatible_movement_input(input: String, current_direction: int) -> bool:
	return (
		Input.is_action_pressed(input)
		&& _snake.get_properties().get_current_direction() != current_direction
		&& _snake.get_properties().get_current_direction() != Directions.get_opposite(current_direction)
	)

func _set_new_snake_direction(direction:int):
	_player_can_set_direction = false
	_snake.get_properties().set_current_direction(direction)

func _handle_snake_movement(delta: float):
	_movement_elapsed_seconds += delta
	var current_delta_seconds = _stage_description.get_snake_base_delta_seconds()
	for i in _snake.get_properties().get_current_length() - 1:
		current_delta_seconds *= _stage_description.get_snake_speedup_factor()
	if _movement_elapsed_seconds >= current_delta_seconds:
		_player_can_set_direction = true
		_movement_elapsed_seconds -= current_delta_seconds
		_snake.move(current_delta_seconds)
		_handle_snake_collision()

func _handle_snake_collision() -> void:
	var head_coordinates: ImmutablePoint = _snake.get_head_coordinates()
	var body_coordinates = _snake.get_body_coordinates()
	var b_index: int = 0
	for b in body_coordinates:
		if head_coordinates.equals_to(b):
			_snake.get_body_part(b_index).on_snake_head_collision()
		b_index += 1
	var edibles_copy = _edibles.duplicate(false)
	for e in edibles_copy:
		if head_coordinates.equals_to(e.get_coordinates()):
			e.on_snake_head_collision()

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
					free_cells.remove(free_cells.find(instance.get_coordinates()))
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
	var h = ImmutablePoint.get_point_index_in_array(
		res,
		_snake.get_head_coordinates()
	)
	if h != -1:
			res.pop_at(h)
	for s in _snake.get_body_coordinates():
		var i = ImmutablePoint.get_point_index_in_array(res, s)
		if i != -1:
			res.pop_at(i)
	for e in _edibles:
		var i = ImmutablePoint.get_point_index_in_array(res, e.get_coordinates())
		if i != -1:
			res.pop_at(i)
	return res
