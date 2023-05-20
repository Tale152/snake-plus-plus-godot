class_name MainMenuScene extends Control

const _MainMenuContent = preload("res://src/menu/main_menu_scene/MainMenuContent.tscn")
const _SettingsMenuScene = preload("res://src/menu/settings_menu_scene/SettingsMenuScene.tscn")
const _TrophiesMenuScene = preload("res://src/menu/trophies_menu/TrophiesMenuScene.tscn")

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
	_NavigationBar.set_left_button_disabled(false)
	_NavigationBar.set_on_left_button_pressed_strategy(funcref(self, "_go_to_trophies"))
	_NavigationBar.set_title_label_text("")
	_NavigationBar.set_right_button_visible(true, "settings")
	_NavigationBar.set_right_button_disabled(false)
	_NavigationBar.set_on_right_button_pressed_strategy(funcref(self, "_go_to_settings"))
	_main_menu_content.scale($MenuSceneControl.get_scaling())

func initialize(main_scene_instance: Control) -> void:
	_main_scene_instance = main_scene_instance
	_main_scene_instance.clear()
	_main_menu_content.initialize(main_scene_instance, self)
	_main_scene_instance.add_child(self)

func _go_to_settings() -> void:
	var settings_menu_scene: SettingsMenuScene = _SettingsMenuScene.instance()
	settings_menu_scene.initialize(_main_scene_instance, self)

func _go_to_trophies() -> void:
	var trophies_menu_scene: TrophiesMenuScene = _TrophiesMenuScene.instance()
	trophies_menu_scene.initialize(_main_scene_instance, self)
