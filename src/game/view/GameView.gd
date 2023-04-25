class_name GameView extends Node

onready var _GameOverMenu: Control = $GuiAreaControl/RectangleRatioContainer/Control/BottomControl/GameOverMenu
onready var _PauseMenu: Control = $GuiAreaControl/RectangleRatioContainer/Control/BottomControl/PauseMenu
onready var _RestartMenu: Control = $GuiAreaControl/RectangleRatioContainer/Control/BottomControl/RestartMenu
onready var _Hud: Control = $GuiAreaControl/RectangleRatioContainer/Control/HudControl/Hud
onready var _Effects: Control = $GuiAreaControl/RectangleRatioContainer/Control/EffectsControl/Effects
onready var _FieldControl: Control = $GuiAreaControl/RectangleRatioContainer/Control/FieldControl
onready var _BottomControl: Control = $GuiAreaControl/RectangleRatioContainer/Control/BottomControl
onready var _PerkEat: AudioStreamPlayer = $PerkEatAudioStreamPlayer
onready var _GameLoop: AudioStreamPlayer = $GameLoopAudioStreamPlayer
onready var _GameOver: AudioStreamPlayer = $GameOverAudioStreamPlayer

var _controller: GameController
var _controls: Control
var _background_cells: Array = []
var _walls: Array = []
var _snake_units: Array = []
var _perks: Array = []

func set_controls(controls: Control):
	_controls = controls
	_BottomControl.add_child(_controls)

func initialize(effects: Dictionary, scale: float) -> void:
	_Hud.scale(scale)
	_PauseMenu.scale_font(scale)
	_RestartMenu.scale_font(scale)
	_GameOverMenu.scale_font(scale)
	_Effects.initialize(effects, scale)
	_controls.scale(scale)

func get_controls() -> Control:
	return _controls

func get_pause_menu() -> Control:
	return _PauseMenu

func get_restart_menu() -> Control:
	return _RestartMenu

func get_game_over_menu() -> Control:
	return _GameOverMenu

func set_controller(controller: GameController):
	_controller = controller

func get_field_px_size(scale: float) -> int:
	return int(floor(_FieldControl.rect_size.x * scale))

func add_background_cell(cell: BackgroundCell) -> void:
	_background_cells.push_back(cell)
	_FieldControl.add_child(cell)
	cell.play_sprite_animation()

func add_wall(wall: WallView) -> void:
	_walls.push_back(wall)
	_FieldControl.add_child(wall)
	wall.play_sprite_animation()

func add_perk(perk: PerkView) -> void:
	_perks.push_back(perk)
	_FieldControl.add_child(perk)
	perk.play_sprite_animation()

func remove_perk(coordinates: Coordinates) -> void:
	for perk in _perks:
		if perk.get_coordinates().equals_to(coordinates):
			_perks.erase(perk)
			_FieldControl.remove_child(perk)

func reset_perks() -> void:
	for perk in _perks:
		_FieldControl.remove_child(perk)
	_perks = []

func print_snake(snake_units: Array, movement_delta: float) -> void:
	for s in _snake_units:
		_FieldControl.remove_child(s)
	_snake_units = snake_units
	var speed_scale: float = 1 / movement_delta
	for i in range(snake_units.size() - 1, -1, -1):
		var unit: SnakeUnitView = snake_units[i]
		_FieldControl.add_child(unit)
		unit.play_sprite_animation(speed_scale)

func print_effects(equipped_effects_timers: Array) -> void:
	_Effects.render(equipped_effects_timers)

func stop_animations() -> void:
	_Hud.stop_animations()
	for background_cell in _background_cells: background_cell.stop_sprite_animation()
	for wall in _walls: wall.stop_sprite_animation()
	for perk in _perks: perk.stop_sprite_animation()
	for snake_unit in _snake_units: snake_unit.stop_sprite_animation()

func resume_animations(movement_delta: float) -> void:
	_Hud.play_animations()
	var speed_scale: float = 1 / movement_delta
	for snake_unit in _snake_units: snake_unit.play_sprite_animation(speed_scale)
	for background_cell in _background_cells: background_cell.play_sprite_animation()
	for wall in _walls: wall.play_sprite_animation()
	for perk in _perks: perk.play_sprite_animation()

func show_controls() -> void: _alter_input_visibility(true, false, false, false)

func show_pause_menu() -> void: _alter_input_visibility(false, true, false, false)

func show_restart_menu() -> void: _alter_input_visibility(false, false, true, false)

func show_game_over_menu() -> void: _alter_input_visibility(false, false, false, true)
	
func _alter_input_visibility(
	controls: bool,
	pause: bool,
	restart: bool,
	game_over: bool
) -> void:
	_controls.visible = controls
	_PauseMenu.visible = pause
	_RestartMenu.visible = restart
	if(game_over): _GameOverMenu.show()
	else: _GameOverMenu.visible = false

func update_hud(
	score: int,
	length: int,
	elapsed_seconds: float
) -> void:
	_Hud.update_values(score, length, elapsed_seconds)

func play_eat_sound() -> void:
	_PerkEat.play()

func play_game_loop_music() -> void:
	_GameLoop.play()

func stop_game_loop_music() -> void:
	_GameLoop.stop()

func play_game_over_sound() -> void:
	_GameOver.play()
