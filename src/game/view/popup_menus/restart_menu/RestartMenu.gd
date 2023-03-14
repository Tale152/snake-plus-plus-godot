class_name RestartMenu extends Control

const _RESTART_LABEL_DEFAULT_FONT_SIZE = 30
const _BUTTONS_DEFAULT_FONT_SIZE = 20
onready var _RestartLabelFont = preload("res://src/game/view/popup_menus/restart_menu/RestartLabel.tres")
onready var _YesButtonFont = preload("res://src/game/view/popup_menus/restart_menu/YesButton.tres")
onready var _NoButtonFont = preload("res://src/game/view/popup_menus/restart_menu/NoButton.tres")

var _invoker

func set_invoker(invoker) -> void:
	_invoker = invoker

func scale_font(scale: float) -> void:
	var restart_font_size = int(floor(_RESTART_LABEL_DEFAULT_FONT_SIZE * scale))
	var buttons_font_size = int(floor(_BUTTONS_DEFAULT_FONT_SIZE * scale))
	_RestartLabelFont.size = restart_font_size
	_YesButtonFont.size = buttons_font_size
	_NoButtonFont.size = buttons_font_size

func _on_YesButton_pressed():
	_invoker.restart()

func _on_NoButton_pressed():
	self.visible = false
	_invoker.change_pause_status()
