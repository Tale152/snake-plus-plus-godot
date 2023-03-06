class_name GameOverMenu extends Control

const GAME_OVER_LABEL_DEFAULT_FONT_SIZE = 30
const BUTTONS_DEFAULT_FONT_SIZE = 20
onready var GameOverLabelFont = preload("res://src/game/popup_menus/game_over_menu/GameOverLabel.tres")
onready var PlayAgainButtonFont = preload("res://src/game/popup_menus/game_over_menu/PlayAgainButton.tres")
onready var BackToMenuButtonFont = preload("res://src/game/popup_menus/game_over_menu/BackToMenuButton.tres")

var _invoker

func set_invoker(invoker) -> void:
	_invoker = invoker

func scale_font(scale: float) -> void:
	var game_over_font_size = int(floor(GAME_OVER_LABEL_DEFAULT_FONT_SIZE * scale))
	var buttons_font_size = int(floor(BUTTONS_DEFAULT_FONT_SIZE * scale))
	GameOverLabelFont.size = game_over_font_size
	PlayAgainButtonFont.size = buttons_font_size
	BackToMenuButtonFont.size = buttons_font_size

func _on_PlayAgainButton_pressed():
	_invoker.restart()

func _on_BackToMenuButton_pressed():
	_invoker.show_menu()
