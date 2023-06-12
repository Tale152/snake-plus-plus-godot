class_name ArcadeMenuScene extends Control

onready var _NavigationBar: NavigationBar = $MenuSceneControl.get_navigation_bar()
const _ArcadeMenuContent = preload("res://src/menu/arcade_menu_scene/ArcadeMenuContent.tscn")
const _ArcadeStageContainer = preload("res://src/menu/arcade_menu_scene/ArcadeStageContainer.tscn")
const _GameView = preload("res://src/game/view/GameView.tscn")

var _arcade_menu_content: ArcadeMenuContent = _ArcadeMenuContent.instance()
var _main_scene_instance: Control
var _main_menu_scene

func _ready():
	_NavigationBar.set_title_label_text(TranslationsManager.get_localized_string(
		TranslationsManager.ARCADE
	))
	_NavigationBar.set_left_button_visible(true, "back")
	_NavigationBar.set_left_button_disabled(false)
	_NavigationBar.set_on_left_button_pressed_strategy(funcref(self, "_go_to_main_menu"))
	_NavigationBar.set_right_button_visible(false)
	_NavigationBar.set_right_button_disabled(true)
	_arcade_menu_content.anchor_left = 0
	_arcade_menu_content.anchor_right = 1
	_arcade_menu_content.anchor_top = 0
	_arcade_menu_content.anchor_bottom = 1
	var stages: Array = _list_available_stages("res://assets/stages")
	var scale: float = $MenuSceneControl.get_scaling()
	for s in stages:
		var container: ArcadeStageContainer = _ArcadeStageContainer.instance()
		container.initialize(
			funcref(self, "_play_stage"),
			s,
			ArcadeStageData.new(str("res://assets/stages/", s, ".json")),
			scale
		)
		_arcade_menu_content.append_stage(container)
	$MenuSceneControl._ContentContainerControl.add_child(_arcade_menu_content)
	_arcade_menu_content.scale(scale)

func initialize(main_scene_instance: Control, main_menu_scene) -> void:
	_main_scene_instance = main_scene_instance
	_main_menu_scene = main_menu_scene
	_main_scene_instance.clear()
	_main_scene_instance.add_child(self)
	_arcade_menu_content.initialize(_main_scene_instance)

func _play_stage(data: ArcadeStageData) -> void:
	_main_scene_instance.play_button_click_sound()
	var scale = $MenuSceneControl.get_scaling()
	var parsed_stage: ParsedStage = JsonStageParser.parse(data.get_stage_path())
	
	var game_view = _GameView.instance()
	_main_scene_instance.clear()
	_main_scene_instance.add_child(game_view)
	var visual_parameters: VisualParameters = VisualParametersHelper \
		.load_visual_parameters(
			game_view.get_field_px_size(scale),
			parsed_stage
		)
	var game_controller: GameController = GameController.new(
		parsed_stage,
		_get_difficulty_settings_values(),
		visual_parameters,
		funcref(self, "_back_to_arcade_menu")
	)
	game_view.set_controller(game_controller)
	game_controller.set_view(game_view, scale)
	_main_scene_instance.add_game_controller(game_controller)
	_main_scene_instance.stop_menu_music()
	game_controller.start_new_game()

func _get_difficulty_settings_values() -> DifficultySettings:
	var difficulty: String = PersistentDifficultySettings.get_arcade_difficulty()
	if difficulty == "Noob": return DifficultySettings.new(12, 0.8, 0.996)
	elif difficulty == "Regular" : return DifficultySettings.new(7, 0.5, 0.99)
	else: return DifficultySettings.new(5, 0.4, 0.984)

func _back_to_arcade_menu() -> void:
	_main_scene_instance.play_button_click_sound()
	_main_scene_instance.clear()
	_main_scene_instance.add_child(self)
	_main_scene_instance.play_menu_music()

func _go_to_main_menu() -> void:
	_main_scene_instance.play_button_click_sound()
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
