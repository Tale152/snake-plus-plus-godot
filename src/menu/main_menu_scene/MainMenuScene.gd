class_name MainMenuScene extends Control

const _MainMenuContent = preload("res://src/menu/main_menu_scene/MainMenuContent.tscn")

onready var _NavigationBar: NavigationBar = $MenuSceneControl.get_navigation_bar()

var _main_scene_instance: Control
var _main_menu_content: MainMenuContent = _MainMenuContent.instance()

func _ready():
	_main_menu_content.anchor_left = 0
	_main_menu_content.anchor_right = 1
	_main_menu_content.anchor_top = 0
	_main_menu_content.anchor_bottom = 1
	$MenuSceneControl._ContentContainerControl.add_child(_main_menu_content)
	_NavigationBar.set_left_button_visible(true, "trophy")
	_NavigationBar.set_left_button_disabled(true)
	_NavigationBar.set_title_label_text("")
	_NavigationBar.set_right_button_visible(true, "settings")
	_NavigationBar.set_right_button_disabled(true)

func initialize(main_scene_instance: Control) -> void:
	_main_scene_instance = main_scene_instance
	_main_scene_instance.clear()
	_main_menu_content.initialize(main_scene_instance, self)
	_main_scene_instance.add_child(self)
