class_name MainMenuContent extends Control

const _ArcadeMenuScene = preload("res://src/menu/arcade_menu_scene/ArcadeMenuScene.tscn")

var _main_scene_instance
var _main_menu_scene

func initialize(main_scene_instance, main_menu_scene) -> void:
	_main_scene_instance = main_scene_instance
	_main_menu_scene = main_menu_scene

func _on_Button_pressed():
	var arcade_menu_scene: ArcadeMenuScene = _ArcadeMenuScene.instance()
	arcade_menu_scene.initialize(_main_scene_instance, _main_menu_scene)
