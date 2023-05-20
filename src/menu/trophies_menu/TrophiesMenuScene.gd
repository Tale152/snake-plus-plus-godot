class_name TrophiesMenuScene extends Control

const _TrophiesMenuContent = preload("res://src/menu/trophies_menu/TrophiesMenuContent.tscn")

onready var _NavigationBar: NavigationBar = $MenuSceneControl.get_navigation_bar()

var _trophies_menu_content: TrophiesMenuContent = _TrophiesMenuContent.instance()
var _main_scene_instance: Control
var _main_menu_scene

func _ready():
	_NavigationBar.set_left_button_visible(true, "back")
	_NavigationBar.set_left_button_disabled(false)
	_NavigationBar.set_on_left_button_pressed_strategy(funcref(self, "_go_to_main_menu"))
	_NavigationBar.set_title_label_text("Trophies")
	_NavigationBar.set_right_button_visible(false)
	_NavigationBar.set_right_button_disabled(true)
	_trophies_menu_content.anchor_left = 0
	_trophies_menu_content.anchor_right = 1
	_trophies_menu_content.anchor_top = 0
	_trophies_menu_content.anchor_bottom = 1
	$MenuSceneControl._ContentContainerControl.add_child(_trophies_menu_content)
	_trophies_menu_content.scale($MenuSceneControl.get_scaling())

func initialize(main_scene_instance: Control, main_menu_scene) -> void:
	_main_scene_instance = main_scene_instance
	_main_menu_scene = main_menu_scene
	_main_scene_instance.clear()
	_main_scene_instance.add_child(self)

func _go_to_main_menu() -> void:
	_main_menu_scene.initialize(_main_scene_instance)
