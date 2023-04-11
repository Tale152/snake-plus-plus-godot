class_name GameView extends Node

onready var _GameOverMenu: Control = $GuiAreaControl/RectangleRatioContainer/Control/BottomControl/GameOverMenu
onready var _PauseMenu: Control = $GuiAreaControl/RectangleRatioContainer/Control/BottomControl/PauseMenu
onready var _RestartMenu: Control = $GuiAreaControl/RectangleRatioContainer/Control/BottomControl/RestartMenu
onready var _Hud: Control = $GuiAreaControl/RectangleRatioContainer/Control/HudControl/Hud
onready var _Effects: Control = $GuiAreaControl/RectangleRatioContainer/Control/EffectsControl/Effects
onready var _FieldControl: Control = $GuiAreaControl/RectangleRatioContainer/Control/FieldControl
onready var _BottomControl: Control = $GuiAreaControl/RectangleRatioContainer/Control/BottomControl

var _controller: GameController

func set_controls(controls: Control): _BottomControl.add_child(controls)

func set_controller(controller: GameController):
	_controller = controller

func get_field_px_size(scale: float) -> int:
	return int(floor(_FieldControl.rect_size.x * scale))

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
