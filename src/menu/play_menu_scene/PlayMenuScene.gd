class_name PlayMenuScene extends Control

onready var _NavigationBar: NavigationBar = $MenuSceneControl.get_navigation_bar()
const _PlayMenuContent = preload("res://src/menu/play_menu_scene/PlayMenuContent.tscn")
const _StageSelectorContainer = preload("res://src/menu/play_menu_scene/StageSelectorContainer.tscn")
const _GameView = preload("res://src/game/view/GameView.tscn")
const _StagePreludeScene = preload("res://src/menu/stage_prelude_menu/StagePreludeScene.tscn")

var _play_menu_content: PlayMenuContent = _PlayMenuContent.instance()
var _main_scene_instance: Control
var _main_menu_scene
var _stages_data: Dictionary
var _stages_helper: StagesHelper = StagesHelper.new()

func _ready():
	_NavigationBar.set_title_label_text(TranslationsManager.get_localized_string(
		TranslationsManager.PLAY
	))
	_NavigationBar.set_left_button_visible(true, "back")
	_NavigationBar.set_left_button_disabled(false)
	_NavigationBar.set_on_left_button_pressed_strategy(funcref(self, "_go_to_main_menu"))
	_NavigationBar.set_right_button_visible(false)
	_NavigationBar.set_right_button_disabled(true)
	_play_menu_content.anchor_left = 0
	_play_menu_content.anchor_right = 1
	_play_menu_content.anchor_top = 0
	_play_menu_content.anchor_bottom = 1
	_play_menu_content.visible = true
	$MenuSceneControl._ContentContainerControl.add_child(_play_menu_content)
	_stages_helper.unlock_initial_stages()

func _populate_stages() -> void:
	_play_menu_content.clear_stages()
	
	var stages: Array = _list_available_stages(StagesHelper.STAGES_PATH)
	var scale: float = $MenuSceneControl.get_scaling()
	for s in stages:
		var container: StageSelectorContainer = _StageSelectorContainer.instance()
		container.initialize(
			funcref(self, "_open_stage_selector_container"),
			s.displayed_name,
			MenuStageData.new(s.filepath, s.uuid),
			scale
		)
		_play_menu_content.append_stage(container)
	_play_menu_content.scale(scale)

func initialize(main_scene_instance: Control, main_menu_scene) -> void:
	_main_scene_instance = main_scene_instance
	_main_menu_scene = main_menu_scene
	_main_scene_instance.clear()
	_main_scene_instance.add_child(self)
	_play_menu_content.initialize(_main_scene_instance)
	_populate_stages()

func _open_stage_selector_container(data: MenuStageData, name: String) -> void:
	_main_scene_instance.play_button_click_sound()
	_StagePreludeScene.instance().initialize_by_play_menu(
		_main_scene_instance, _main_menu_scene, self, data, name
	)

func _go_to_main_menu() -> void:
	_main_scene_instance.play_button_click_sound()
	_main_menu_scene.initialize(_main_scene_instance)

func _list_available_stages(path: String) -> Array:
	var files = _stages_helper.list_stage_files()
	_stages_data = PersistentStagesData.get_stages()
	var res = []
	for f in files:
		var filepath: String = path + "/" + f
		var file = File.new()
		file.open(filepath, File.READ)
		var json_data = parse_json(file.get_as_text())
		file.close()
		var name_dictionary: Dictionary = json_data["info"]["name"]
		var name: String = name_dictionary[PersistentUserSettings.get_language()]
		if name == null or name == "":
			name = name_dictionary[TranslationsManager.FALLBACK_LANGUAGE_ID]
		if name == null or name == "":
			name = "ERROR: no name"
		res.push_back({
			filepath = filepath,
			displayed_name = name,
			uuid = json_data["uuid"]
		})
	return res
