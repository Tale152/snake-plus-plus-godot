class_name GameOverMenu extends Control

const _ENABLE_BUTTONS_DELAY_SECONDS: float = 1.2
const _GAME_OVER_LABEL_DEFAULT_FONT_SIZE = 30
const _BUTTONS_DEFAULT_FONT_SIZE = 20
onready var _GameOverLabelFont = preload("res://src/game/view/popup_menus/game_over_menu/GameOverLabel.tres")
onready var _PlayAgainButtonFont = preload("res://src/game/view/popup_menus/game_over_menu/PlayAgainButton.tres")
onready var _BackToMenuButtonFont = preload("res://src/game/view/popup_menus/game_over_menu/BackToMenuButton.tres")

var _on_play_again_button_pressed_strategy: FuncRef
var _on_back_to_menu_button_pressed_strategy: FuncRef

func set_on_play_again_button_pressed_strategy(strategy: FuncRef) -> void:
	_on_play_again_button_pressed_strategy = strategy

func set_on_back_to_menu_button_pressed_strategy(strategy: FuncRef) -> void:
	_on_back_to_menu_button_pressed_strategy = strategy

func show() -> void:
	self.visible = true
	WaitTimer.new() \
		.set_seconds(_ENABLE_BUTTONS_DELAY_SECONDS) \
		.set_parent_node(self) \
		.set_callback(funcref(self, "_enable_buttons")) \
		.wait()

func scale_font(scale: float) -> void:
	var game_over_font_size = int(floor(_GAME_OVER_LABEL_DEFAULT_FONT_SIZE * scale))
	var buttons_font_size = int(floor(_BUTTONS_DEFAULT_FONT_SIZE * scale))
	_GameOverLabelFont.size = game_over_font_size
	_PlayAgainButtonFont.size = buttons_font_size
	_BackToMenuButtonFont.size = buttons_font_size

func _enable_buttons() -> void:
	$PlayAgainButton.disabled = false
	$BackToMenuButton.disabled = false

func _on_PlayAgainButton_pressed():
	_on_play_again_button_pressed_strategy.call_func()

func _on_BackToMenuButton_pressed():
	_on_back_to_menu_button_pressed_strategy.call_func()
