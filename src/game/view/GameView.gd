class_name GameView extends Node

onready var _GameOverMenu: Control = $GuiAreaControl/RectangleRatioContainer/Control/BottomControl/GameOverMenu
onready var _PauseMenu: Control = $GuiAreaControl/RectangleRatioContainer/Control/BottomControl/PauseMenu
onready var _RestartMenu: Control = $GuiAreaControl/RectangleRatioContainer/Control/BottomControl/RestartMenu
onready var _Hud: Control = $GuiAreaControl/RectangleRatioContainer/Control/HudControl/Hud
onready var _Effects: Control = $GuiAreaControl/RectangleRatioContainer/Control/EffectsControl/Effects
onready var _FieldControl: Control = $GuiAreaControl/RectangleRatioContainer/Control/FieldControl
onready var _BottomControl: Control = $GuiAreaControl/RectangleRatioContainer/Control/BottomControl

var _controller: GameController
var _background_cells: Array = []
var _walls: Array = []
var _snake_units: Array = []

func set_controls(controls: Control): _BottomControl.add_child(controls)

func set_controller(controller: GameController):
	_controller = controller

func get_field_px_size(scale: float) -> int:
	return int(floor(_FieldControl.rect_size.x * scale))

func add_background_cell(cell: BackgroundCell) -> void:
	_background_cells.push_back(cell)
	_FieldControl.add_child(cell)
	cell.play_sprite_animation(0.3)

func add_wall(wall: WallView) -> void:
	_walls.push_back(wall)
	_FieldControl.add_child(wall)
	wall.play_sprite_animation()

func print_snake(snake_units: Array, speed_scale: float) -> void:
	for s in _snake_units:
		_FieldControl.remove_child(s)
	_snake_units = snake_units
	for i in range(snake_units.size() - 1, -1, -1):
		var unit: SnakeUnitView = snake_units[i]
		_FieldControl.add_child(unit)
		unit.play_sprite_animation(speed_scale)

func show_pause_menu() -> void:
	_PauseMenu.visible = true

func show_restart_menu() -> void:
	_RestartMenu.visible = true

func update_hud(
	score: int,
	length: int,
	elapsed_seconds: float
) -> void:
	_Hud.update_values(score, length, elapsed_seconds)
