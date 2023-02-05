class_name Game extends Node

# --- constants ---
const EDIBLES_SPAWN_ATTEMPT_FREQUENCY = 1

var rng = RandomNumberGenerator.new()
var _game_over: bool = false
var _next_direction: int
var _stage_description: StageDescription
var _visual_parameters: VisualParameters
var _snake
var _movement_elapsed_seconds = 0
var _spawn_attempt_elapsed_seconds = 0
var _edibles = []
var _cells
var _to_be_removed_queue = []

var _edible_builder: EdibleBuilder

func _init(
	stage_description: StageDescription,
	visual_parameters: VisualParameters
):
	_stage_description = stage_description
	_visual_parameters = visual_parameters
	_next_direction = -1
	_set_background()
	_init_cells()
	_setup_snake()
	_edible_builder = EdibleBuilder.new(
		_snake,
		self,
		_visual_parameters
	)

# --- core functions ---

func tick(delta):
	_handle_snake_movement(delta)
	_handle_to_be_removed_queue_clear()
	_handle_edibles_spawn(delta)

func _unhandled_input(event):
	if _next_direction == -1:
		var direction: int = -1
		if event is InputEventScreenDrag:
			direction = SwipeMovementInput.get_input_direction(event) 
		elif event is InputEventKey:
			direction = KeyMovementInput.get_input_direction()
		if direction != -1 && _compatible_movement_input(direction):
			_next_direction = direction

func remove_edible(edible) -> void:
	_edibles.erase(edible)
	if edible != null:
		_to_be_removed_queue.push_back(edible)

func set_game_over(status) -> void:
	_game_over = status

func is_game_over() -> bool:
	return _game_over

func get_stage_description() -> StageDescription:
	return _stage_description

func get_visual_parameters() -> VisualParameters:
	return _visual_parameters

# --- private setup functions ---

func _set_background() -> void:
	var field_size = _stage_description.get_field_size()
	var sprites = _visual_parameters.get_background_sprites()
	for x in range(0, field_size.get_width()):
		for y in range(0, field_size.get_height()):
			var cell = Area2D.new()
			cell.position = PositionCalculator.calculate_position(
				ImmutablePoint.new(x, y),
				_visual_parameters.get_cell_pixels_size(),
				_visual_parameters.get_game_pixels_offset()
			)
			var cell_sprite = sprites[rng.randi() % sprites.size()].duplicate()
			cell_sprite.speed_scale = 0.3
			cell.add_child(cell_sprite)
			add_child(cell)
			cell_sprite.play()

func _init_cells() -> void:
	_cells = []
	for x in _stage_description.get_field_size().get_width():
		for y in _stage_description.get_field_size().get_height():
			_cells.push_back(ImmutablePoint.new(x, y))

func _setup_snake() -> void:
	_snake = Snake.new(self)
	add_child(_snake)

# --- private process functions ---

func _compatible_movement_input(input_direction: int) -> bool:
	var current_direction = _snake.get_properties().get_current_direction() 
	return (
		current_direction != input_direction &&
		current_direction != Directions.get_opposite(input_direction)
	)

func _handle_snake_movement(delta: float) -> void:
	_movement_elapsed_seconds += delta
	var current_delta_seconds = _stage_description.get_snake_base_delta_seconds()
	for i in _snake.get_properties().get_current_length() - 1:
		current_delta_seconds *= _stage_description.get_snake_speedup_factor()
	if _movement_elapsed_seconds >= current_delta_seconds:
		if _next_direction != -1:
			_snake.get_properties().set_current_direction(_next_direction)
			_next_direction = -1
		_movement_elapsed_seconds -= current_delta_seconds
		_snake.move(current_delta_seconds)
		_handle_snake_collision()

func _handle_snake_collision() -> void:
	var head_coordinates: ImmutablePoint = _snake.get_head().get_placement().get_coordinates()
	var body_parts = _snake.get_body_parts()
	var b_index: int = 0
	for b in body_parts:
		if head_coordinates.equals_to(b.get_placement().get_coordinates()):
			b.on_snake_head_collision()
		b_index += 1
	if !_game_over:
		var edibles_copy = _edibles.duplicate(false)
		for e in edibles_copy:
			if head_coordinates.equals_to(e.get_coordinates()):
				e.on_snake_head_collision()

func _handle_to_be_removed_queue_clear() -> void:
	for r in _to_be_removed_queue:
		r.queue_free()
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
				if instance != null:
					free_cells.remove(free_cells.find(instance.get_coordinates()))
					_edibles.push_back(instance)
					add_child(instance)

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
		_snake.get_head().get_placement().get_coordinates()
	)
	if h != -1:
			res.pop_at(h)
	for b in _snake.get_body_parts():
		var i = ImmutablePoint.get_point_index_in_array(res, b.get_placement().get_coordinates())
		if i != -1:
			res.pop_at(i)
	for e in _edibles:
		var i = ImmutablePoint.get_point_index_in_array(res, e.get_coordinates())
		if i != -1:
			res.pop_at(i)
	return res
