class_name RestartMenu extends Control

const _RESTART_LABEL_DEFAULT_FONT_SIZE = 30
const _BUTTONS_DEFAULT_FONT_SIZE = 20
onready var _RestartLabelFont = preload("res://src/game/view/popup_menus/restart_menu/RestartLabel.tres")
onready var _YesButtonFont = preload("res://src/game/view/popup_menus/restart_menu/YesButton.tres")
onready var _NoButtonFont = preload("res://src/game/view/popup_menus/restart_menu/NoButton.tres")

var _on_yes_button_pressed_strategy: FuncRef
var _on_no_button_pressed_strategy: FuncRef

func set_on_yes_button_pressed_strategy(strategy: FuncRef) -> void:
	_on_yes_button_pressed_strategy = strategy

func set_on_no_button_pressed_strategy(strategy: FuncRef) -> void:
	_on_no_button_pressed_strategy = strategy

func scale_font(scale: float) -> void:
	var restart_font_size = int(floor(_RESTART_LABEL_DEFAULT_FONT_SIZE * scale))
	var buttons_font_size = int(floor(_BUTTONS_DEFAULT_FONT_SIZE * scale))
	_RestartLabelFont.size = restart_font_size
	_YesButtonFont.size = buttons_font_size
	_NoButtonFont.size = buttons_font_size

func _on_YesButton_pressed():
	_on_yes_button_pressed_strategy.call_func()

func _on_NoButton_pressed():
	_on_no_button_pressed_strategy.call_func()
