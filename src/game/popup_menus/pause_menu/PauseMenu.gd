class_name PauseMenu extends Control

const PAUSE_LABEL_DEFAULT_FONT_SIZE = 30
const BUTTONS_DEFAULT_FONT_SIZE = 20
onready var PauseLabelFont = preload("res://src/game/popup_menus/pause_menu/PauseLabel.tres")
onready var ContinueButtonFont = preload("res://src/game/popup_menus/pause_menu/ContinueButton.tres")
onready var RestartButtonFont = preload("res://src/game/popup_menus/pause_menu/RestartButton.tres")
onready var BackToMenuButtonFont = preload("res://src/game/popup_menus/pause_menu/BackToMenu.tres")

var _invoker

func set_invoker(invoker) -> void:
	_invoker = invoker

func scale_font(scale: float) -> void:
	var pause_font_size = int(floor(PAUSE_LABEL_DEFAULT_FONT_SIZE * scale))
	var buttons_font_size = int(floor(BUTTONS_DEFAULT_FONT_SIZE * scale))
	PauseLabelFont.size = pause_font_size
	ContinueButtonFont.size = buttons_font_size
	RestartButtonFont.size = buttons_font_size
	BackToMenuButtonFont.size = buttons_font_size

func _on_ContinueButton_pressed():
	self.visible = false
	_invoker.change_pause_status()

func _on_RestartButton_pressed():
	_invoker.restart()

func _on_BackToMenuButton_pressed():
	_invoker.show_menu()
