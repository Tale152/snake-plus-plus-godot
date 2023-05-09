extends Control

const _MainMenuScene = preload("res://src/menu/main_menu_scene/MainMenuScene.tscn")

func _ready():
	var main_menu_scene = _MainMenuScene.instance()
	main_menu_scene.initialize(self)

func clear() -> void:
	for n in get_children():
		remove_child(n)
