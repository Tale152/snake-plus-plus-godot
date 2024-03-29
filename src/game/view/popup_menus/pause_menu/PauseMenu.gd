class_name PauseMenu extends Control

const PAUSE_LABEL_DEFAULT_FONT_SIZE = 30
const BUTTONS_DEFAULT_FONT_SIZE = 20
onready var PauseLabelFont = preload("res://src/game/view/popup_menus/pause_menu/PauseLabel.tres")
onready var ContinueButtonFont = preload("res://src/game/view/popup_menus/pause_menu/ContinueButton.tres")
onready var RestartButtonFont = preload("res://src/game/view/popup_menus/pause_menu/RestartButton.tres")
onready var BackToMenuButtonFont = preload("res://src/game/view/popup_menus/pause_menu/BackToMenu.tres")

var _on_continue_button_pressed_strategy: FuncRef
var _on_restart_button_pressed_strategy: FuncRef
var _on_back_to_menu_button_pressed_strategy: FuncRef

func set_on_continue_button_pressed_strategy(strategy: FuncRef) -> void:
	_on_continue_button_pressed_strategy = strategy

func set_on_restart_button_pressed_strategy(strategy: FuncRef) -> void:
	_on_restart_button_pressed_strategy = strategy

func set_on_back_to_menu_button_pressed_strategy(strategy: FuncRef) -> void:
	_on_back_to_menu_button_pressed_strategy = strategy

func scale_font(scale: float) -> void:
	var pause_font_size = int(floor(PAUSE_LABEL_DEFAULT_FONT_SIZE * scale))
	var buttons_font_size = int(floor(BUTTONS_DEFAULT_FONT_SIZE * scale))
	PauseLabelFont.size = pause_font_size
	ContinueButtonFont.size = buttons_font_size
	RestartButtonFont.size = buttons_font_size
	BackToMenuButtonFont.size = buttons_font_size

func _on_ContinueButton_pressed():
	self.visible = false
	_on_continue_button_pressed_strategy.call_func()

func _on_RestartButton_pressed():
	_on_restart_button_pressed_strategy.call_func()

func _on_BackToMenuButton_pressed():
	_on_back_to_menu_button_pressed_strategy.call_func()
