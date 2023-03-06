class_name Game extends Node

onready var TimeLabelFont = preload("res://assets/fonts/TimeLabel.tres")
onready var ScoreLabelFont = preload("res://assets/fonts/ScoreLabel.tres")
onready var LengthLabelFont = preload("res://assets/fonts/LengthLabel.tres")
onready var GameOverMenu: Control = $GuiAreaControl/RectangleRatioContainer/Control/BottomControl/GameOverMenu
onready var PauseMenu: Control = $GuiAreaControl/RectangleRatioContainer/Control/BottomControl/PauseMenu
const FONT_DEFAULT_SIZE: int = 17
const SCORE_SPRITE_DEFAULT_POSITION: Vector2 = Vector2(15, 15)
const LENGTH_SPRITE_DEFAULT_POSITION: Vector2 = Vector2(162, 15)
const TIME_SPRITE_DEFAULT_POSITION: Vector2 = Vector2(224, 15)

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
var _snake: Snake
var _snake_properties: SnakeProperties
var _snake_head: SnakeHead
var _movement_elapsed_seconds: float = 0
var _spawn_attempt_elapsed_seconds: float = 0
var _current_snake_delta_seconds: float
var _edibles: Dictionary
var _walls: Array
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
	rng.randomize()
	_invoker = invoker
	_stage_description = stage_description
	_visual_parameters = visual_parameters
	for r in _stage_description.get_instantaneous_edible_rules():
		_edibles[r.get_type()] = []
	_set_background()
	_init_cells()
	_set_walls()
	_setup_snake()
	var scale = _get_scale()
	_scale_hud(scale)
	_edible_builder = EdibleBuilder.new(_snake, self)
	_elapsed_seconds = 0
	GameOverMenu.set_invoker(invoker)
	GameOverMenu.scale_font(scale)
	PauseMenu.set_invoker(invoker)
	PauseMenu.scale_font(scale)

func _scale_hud(scale: float) -> void:
	var font_size = int(floor(FONT_DEFAULT_SIZE * scale))
	TimeLabelFont.size = font_size
	ScoreLabelFont.size = font_size
	LengthLabelFont.size = font_size
	var score_sprite = $GuiAreaControl/RectangleRatioContainer/Control/HudControl/ScoreAnimatedSprite
	_scale_and_reposition_hud_sprite(score_sprite, scale, SCORE_SPRITE_DEFAULT_POSITION)
	var length_sprite = $GuiAreaControl/RectangleRatioContainer/Control/HudControl/LengthAnimatedSprite
	_scale_and_reposition_hud_sprite(length_sprite, scale, LENGTH_SPRITE_DEFAULT_POSITION)
	var time_sprite = $GuiAreaControl/RectangleRatioContainer/Control/HudControl/TimeAnimatedSprite
	_scale_and_reposition_hud_sprite(time_sprite, scale, TIME_SPRITE_DEFAULT_POSITION)

func _scale_and_reposition_hud_sprite(
	sprite: AnimatedSprite,
	scale: float,
	default_position: Vector2
) -> void:
	var sprite_source_size = sprite.get_sprite_frames().get_frame("default",0).get_width()
	var basic_scaling = 1 / (sprite_source_size / 25.0)
	var window_scaling = scale * basic_scaling
	sprite.set_scale(Vector2(window_scaling, window_scaling))
	sprite.position = Vector2(default_position.x * scale, default_position.y * scale)

func _get_scale() -> float:
	var project_height = ProjectSettings.get("display/window/size/height")
	var project_width = ProjectSettings.get("display/window/size/width")
	var original_ratio = project_height / project_width
	var screen_size = get_tree().get_root().size
	var runtime_ratio = screen_size.y / screen_size.x
	if runtime_ratio >= original_ratio:
		return screen_size.x / project_width
	else:
		return screen_size.y / project_height

func get_field_px_size() -> int:
	return int(floor(
		$GuiAreaControl/RectangleRatioContainer/Control.rect_size.x * _get_scale()
	))

func tick(delta: float) -> void:
	_elapsed_seconds += delta
	_snake.tick_effects(delta)
	_update_hud()
	_handle_edibles_expire(delta)
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
		for wall in _walls:
			wall.stop_sprite_animation()
		for type in _edibles.keys():
			for e in _edibles[type]:
				e.stop_sprite_animation()
		# TODO stop hud sprites
		GameOverMenu.visible = true

func is_game_over() -> bool:
	return _game_over

func get_stage_description() -> StageDescription:
	return _stage_description

func get_visual_parameters() -> VisualParameters:
	return _visual_parameters

func get_snake():
	return _snake

func get_player() -> Player:
	return _player

# --- private setup functions ---

func _set_background() -> void:
	_background_cells = BackgroundGenerator.create_background_cells(
		_stage_description, _visual_parameters
	)
	for c in _background_cells:
		$GuiAreaControl/RectangleRatioContainer/Control/FieldControl.add_child(c)
		c.play_sprite_animation(0.3)

func _init_cells() -> void:
	_cells = []
	for x in _stage_description.get_field_size().get_width():
		for y in _stage_description.get_field_size().get_height():
			_cells.push_back(ImmutablePoint.new(x, y))

func _set_walls() -> void:
	_walls = []
	for wp in _stage_description.get_walls_points():
		var wall = Wall.new(wp, self)
		_walls.push_back(wall)
		$GuiAreaControl/RectangleRatioContainer/Control/FieldControl.add_child(wall)
		
func _setup_snake() -> void:
	_snake = Snake.new(self)
	_snake_properties = _snake.get_properties()
	_snake_head = _snake.get_head()
	_current_snake_delta_seconds = _calculate_snake_current_delta_seconds()
	$GuiAreaControl/RectangleRatioContainer/Control/FieldControl.add_child(_snake)

# --- private process functions ---

func _compatible_movement_input(
	current_direction: int,
	input_direction: int
) -> bool:
	return (
		current_direction != input_direction &&
		current_direction != Directions.get_opposite(input_direction)
	)

func _handle_edibles_expire(delta: float) -> void:
	var edibles_copy = _edibles.duplicate(true)
	for type in edibles_copy.keys():
		for e in edibles_copy[type]:
			e.tick(delta)
			if e.is_expired():
				remove_edible(e)

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
	return current_delta_seconds * _snake.get_properties().get_speed_multiplier()

func _handle_snake_collision() -> void:
	var head_coordinates: ImmutablePoint = _snake_head.get_placement().get_coordinates()
	var body_parts = _snake.get_body_parts()
	for w in _walls:
		if head_coordinates.equals_to(w.get_coordinates()):
			w.on_snake_head_collision()
	if !_game_over:
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
					_remove_from_immutable_points_array(free_cells, instance.get_coordinates())
					_edibles[ir.get_type()].push_back(instance)
					$GuiAreaControl/RectangleRatioContainer/Control/FieldControl.add_child(instance)

func _remove_from_immutable_points_array(arr: Array, p: ImmutablePoint) -> bool:
	var i = 0
	for e in arr:
		if p.equals_to(e):
			arr.remove(i)
			return true;
		i += 1;
	return false

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
	for w in _walls:
		var i = ImmutablePoint.get_point_index_in_array(res, w.get_coordinates())
		if i != -1:
			res.pop_at(i)
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
	var length_text = str(_snake.get_properties().get_current_length())
	$GuiAreaControl/RectangleRatioContainer/Control/HudControl/LengthLabel.text = length_text
	var score_text = str(_player.get_points())
	$GuiAreaControl/RectangleRatioContainer/Control/HudControl/ScoreLabel.text = score_text
	var seconds = floor(_elapsed_seconds)
	var time_text = ""
	if seconds < 60:
		time_text = str("0:", seconds if seconds > 9 else str(0, seconds))
	else:
		var minutes = floor(seconds / 60)
		seconds = seconds - minutes * 60
		time_text = str(minutes, ":", seconds if seconds > 9 else str(0, seconds))
	$GuiAreaControl/RectangleRatioContainer/Control/HudControl/TimeLabel.text = time_text
	var effects: String = ""
	for t in _snake.get_effects_timers():
		effects += str(
			t.get_effect_type(), " ",
			t.get_total_time() - floor(t.get_elapsed_time()),  " | "
		)
	if effects.length() > 0:
		effects.erase(effects.length() - 3, 3)
	$GuiAreaControl/RectangleRatioContainer/Control/EffectsControl/EffectsLabel.text = effects

func _on_PauseButton_pressed():
	_invoker.change_pause_status()
	PauseMenu.visible = true

func _on_UpButton_pressed():
	self.direction_input(Directions.get_up())

func _on_DownButton_pressed():
	self.direction_input(Directions.get_down())

func _on_LeftButton_pressed():
	self.direction_input(Directions.get_left())

func _on_RightButton_pressed():
	self.direction_input(Directions.get_right())
