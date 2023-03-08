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
var _stage_description: StageDescription
var _visual_parameters: VisualParameters
var _snake: Snake
var _snake_properties: SnakeProperties
var _snake_head: SnakeHead
var _movement_elapsed_seconds: float = 0
var _spawn_attempt_elapsed_seconds: float = 0
var _edibles: Dictionary
var _walls: Array
var _to_be_removed_queue: Array = []
var _background_cells: Array
var _elapsed_seconds: float = 0.0
var _input_handler: GameDirectionInputHandler = GameDirectionInputHandler.new()
var _snake_delta_seconds_calculator: SnakeDeltaSecondsCalculator
var _free_cells_handler: FreeCellsHandler

var _edible_builder: EdibleBuilder

func initialize(
	invoker,
	stage_description: StageDescription,
	visual_parameters: VisualParameters,
	controls: Control
):
	rng.randomize()
	_invoker = invoker
	_stage_description = stage_description
	_visual_parameters = visual_parameters
	for r in _stage_description.get_instantaneous_edible_rules():
		_edibles[r.get_type()] = []
	_set_background()
	_set_walls()
	_setup_snake()
	_free_cells_handler = FreeCellsHandler.new(
		stage_description.get_field_size(), _snake
	)
	var scale = invoker.get_scale()
	_scale_hud(scale)
	_edible_builder = EdibleBuilder.new(_snake, self)
	_snake_delta_seconds_calculator = SnakeDeltaSecondsCalculator.new(
		stage_description.get_snake_base_delta_seconds(),
		stage_description.get_snake_speedup_factor()
	)
	GameOverMenu.set_invoker(invoker)
	GameOverMenu.scale_font(scale)
	PauseMenu.set_invoker(invoker)
	PauseMenu.scale_font(scale)
	$GuiAreaControl/RectangleRatioContainer/Control/BottomControl.add_child(controls)
	$GuiAreaControl/RectangleRatioContainer/Control/BottomControl.move_child(controls, 0)

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

func get_field_px_size(scale: float) -> int:
	return int(floor(
		$GuiAreaControl/RectangleRatioContainer/Control.rect_size.x * scale
	))

func show_pause_menu() -> void:
	PauseMenu.visible = true

func tick(delta: float) -> void:
	_elapsed_seconds += delta
	_snake.tick_effects(delta)
	_update_hud()
	_handle_edibles_expire(delta)
	_handle_snake_movement(delta)
	_handle_to_be_removed_queue_clear()
	_handle_edibles_spawn(delta)

func direction_input(input: int) -> void:
	# warning-ignore:return_value_discarded
	_input_handler.submit_input(
		_snake_properties.get_current_direction(),
		input,
		_movement_elapsed_seconds,
		_snake_delta_seconds_calculator.get_last_calculated_delta()
	)

func remove_edible(edible: Edible) -> void:
	_edibles[edible.get_type()].erase(edible)
	_to_be_removed_queue.push_back(edible)

func set_game_over(status) -> void:
	_game_over = status
	if _game_over:
		_stop_all_sprite_animations()
		GameOverMenu.show()

func _stop_all_sprite_animations() -> void:
	_snake_head.stop_sprite_animation()
	_stop_sprite_animations_in_array(_snake.get_body_parts())
	_stop_sprite_animations_in_array(_background_cells)
	_stop_sprite_animations_in_array(_walls)
	for type in _edibles.keys():
		_stop_sprite_animations_in_array(_edibles[type])
	# TODO stop hud sprites

func _stop_sprite_animations_in_array(arr: Array) -> void:
	for elem in arr: elem.stop_sprite_animation()

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
	$GuiAreaControl/RectangleRatioContainer/Control/FieldControl.add_child(_snake)

# --- private process functions ---

func _handle_edibles_expire(delta: float) -> void:
	var edibles_copy = _edibles.duplicate(true)
	for type in edibles_copy.keys():
		for e in edibles_copy[type]:
			e.tick(delta)
			if e.is_expired():
				remove_edible(e)

func _handle_snake_movement(delta: float) -> void:
	_movement_elapsed_seconds += delta
	var current_snake_delta_seconds = _snake_delta_seconds_calculator.calculate_current_delta_seconds(
		_snake_properties.get_current_length() - 1,
		_snake_properties.get_speed_multiplier()
	)
	if _movement_elapsed_seconds >= current_snake_delta_seconds:
		var next_direction = _input_handler.get_next_direction()
		if next_direction != -1:
			_snake_properties.set_current_direction(next_direction)
		_movement_elapsed_seconds -= current_snake_delta_seconds
		_snake.move(current_snake_delta_seconds)
		_handle_snake_collision()

func _handle_snake_collision() -> void:
	var head_coordinates: ImmutablePoint = _snake_head.get_placement().get_coordinates()
	for w in _walls:
		if head_coordinates.equals_to(w.get_coordinates()):
			w.on_snake_head_collision()
	if !_game_over:
		for b in _snake.get_body_parts():
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
		var free_cells = _free_cells_handler.get_free_cells(_walls, _edibles)
		# instantaneous edibles spawn attempts
		for ir in _stage_description.get_instantaneous_edible_rules():
			var current_instances_number: int = _edibles[ir.get_type()].size()
			if ir.can_spawn(current_instances_number, rng.randf()):
				var instance = _edible_builder \
					.build_new() \
					.set_rules(ir) \
					.set_free_cells(free_cells) \
					.build()
				if instance != null: # is is possible that no compatible free cell is found
					instance.get_coordinates().remove_from_array(free_cells)
					_edibles[ir.get_type()].push_back(instance)
					$GuiAreaControl/RectangleRatioContainer/Control/FieldControl.add_child(instance)

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
