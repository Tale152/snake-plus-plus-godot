class_name ArcadeMenuScene extends Control

onready var _NavigationBar: NavigationBar = $MenuSceneControl.get_navigation_bar()
const _ArcadeMenuContent = preload("res://src/menu/arcade_menu_scene/ArcadeMenuContent.tscn")
const _ArcadeStageContainer = preload("res://src/menu/arcade_menu_scene/ArcadeStageContainer.tscn")

var _arcade_menu_content: ArcadeMenuContent = _ArcadeMenuContent.instance()
var _main_scene_instance: Control
var _main_menu_scene

func _ready():
	_NavigationBar.set_title_label_text("Arcade")
	_NavigationBar.set_left_button_visible(true, "back")
	_NavigationBar.set_left_button_disabled(false)
	_NavigationBar.set_on_left_button_pressed_strategy(funcref(self, "_go_to_main_menu"))
	_NavigationBar.set_right_button_visible(true, "info")
	_NavigationBar.set_right_button_disabled(true)
	_arcade_menu_content.anchor_left = 0
	_arcade_menu_content.anchor_right = 1
	_arcade_menu_content.anchor_top = 0
	_arcade_menu_content.anchor_bottom = 1
	var stages: Array = _list_available_stages("res://assets/stages")
	for s in stages:
		var container: ArcadeStageContainer = _ArcadeStageContainer.instance()
		container.initialize(
			funcref(self, "_print_from_stage_container"),
			s,
			$MenuSceneControl.get_scaling()
		)
		_arcade_menu_content.append_stage(container)
	$MenuSceneControl._ContentContainerControl.add_child(_arcade_menu_content)

func _print_from_stage_container(text: String) -> void:
	print(text)

func initialize(main_scene_instance: Control, main_menu_scene) -> void:
	_main_scene_instance = main_scene_instance
	_main_menu_scene = main_menu_scene
	_main_scene_instance.clear()
	_main_scene_instance.add_child(self)

func _go_to_main_menu() -> void:
	_main_menu_scene.initialize(_main_scene_instance)

func _list_available_stages(path: String) -> Array:
	var files = _list_files_in_directory(path)
	var res = []
	for f in files:
		res.push_back(f.replace(".json", ""))
	return res

func _list_files_in_directory(path):
	var files = []
	var dir = Directory.new()
	dir.open(path)
	dir.list_dir_begin()

	while true:
		var file = dir.get_next()
		if file == "":
			break
		elif not file.begins_with("."):
			files.append(file)

	dir.list_dir_end()

	return files
