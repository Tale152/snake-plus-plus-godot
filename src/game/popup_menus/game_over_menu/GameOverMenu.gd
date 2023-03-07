class_name GameOverMenu extends Control

const _ENABLE_BUTTONS_DELAY_SECONDS: float = 1.2
const _GAME_OVER_LABEL_DEFAULT_FONT_SIZE = 30
const _BUTTONS_DEFAULT_FONT_SIZE = 20
onready var _GameOverLabelFont = preload("res://src/game/popup_menus/game_over_menu/GameOverLabel.tres")
onready var _PlayAgainButtonFont = preload("res://src/game/popup_menus/game_over_menu/PlayAgainButton.tres")
onready var _BackToMenuButtonFont = preload("res://src/game/popup_menus/game_over_menu/BackToMenuButton.tres")

var _invoker

func set_invoker(invoker) -> void:
	_invoker = invoker

func scale_font(scale: float) -> void:
	var game_over_font_size = int(floor(_GAME_OVER_LABEL_DEFAULT_FONT_SIZE * scale))
	var buttons_font_size = int(floor(_BUTTONS_DEFAULT_FONT_SIZE * scale))
	_GameOverLabelFont.size = game_over_font_size
	_PlayAgainButtonFont.size = buttons_font_size
	_BackToMenuButtonFont.size = buttons_font_size

func show() -> void:
	self.visible = true
	WaitTimer.new() \
		.set_seconds(_ENABLE_BUTTONS_DELAY_SECONDS) \
		.set_parent_node(self) \
		.set_callback(funcref(self, "_enable_buttons")) \
		.wait()

func _enable_buttons() -> void:
	$PlayAgainButton.disabled = false
	$BackToMenuButton.disabled = false

func _on_PlayAgainButton_pressed():
	_invoker.restart()

func _on_BackToMenuButton_pressed():
	_invoker.show_menu()
