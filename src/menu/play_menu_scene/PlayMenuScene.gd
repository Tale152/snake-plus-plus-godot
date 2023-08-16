class_name PlayMenuScene extends Control

onready var _NavigationBar: NavigationBar = $MenuSceneControl.get_navigation_bar()
const _PlayMenuContent = preload("res://src/menu/play_menu_scene/PlayMenuContent.tscn")
const _StagePrelude = preload("res://src/menu/play_menu_scene/StagePrelude.tscn")
const _StageSelectorContainer = preload("res://src/menu/play_menu_scene/StageSelectorContainer.tscn")
const _GameView = preload("res://src/game/view/GameView.tscn")

var _play_menu_content: PlayMenuContent = _PlayMenuContent.instance()
var _stage_prelude: StagePrelude = _StagePrelude.instance()
var _main_scene_instance: Control
var _main_menu_scene
var _stages_data: Dictionary
var _arcade_record_helper: ArcadeRecordHelper
var _challenge_record_helper: ChallengeRecordHelper
var _new_record_strategy: FuncRef
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
	_stage_prelude.anchor_left = 0
	_stage_prelude.anchor_right = 1
	_stage_prelude.anchor_top = 0
	_stage_prelude.anchor_bottom = 1
	_stage_prelude.visible = false
	$MenuSceneControl._ContentContainerControl.add_child(_stage_prelude)
	_stages_helper.unlock_initial_stages()
	_populate_stages()
	

func _populate_stages() -> void:
	_play_menu_content.clear_stages()
	
	var stages: Array = _list_available_stages(StagesHelper.STAGES_PATH)
	var scale: float = $MenuSceneControl.get_scaling()
	for s in stages:
		var container: StageSelectorContainer = _StageSelectorContainer.instance()
		container.initialize(
			funcref(self, "_open_stage_selector_container"),
			s.displayed_name,
			MenuStageData.new(s.filepath, s.uuid, s.stars, s.record, s.unlocked),
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

func _open_stage_selector_container(data: MenuStageData, name: String) -> void:
	_stage_prelude.initialize(
		data,
		name,
		funcref(self, "_play_stage"),
		funcref(self, "_back_to_play_menu")
	)
	_stage_prelude.scale($MenuSceneControl.get_scaling())
	_play_menu_content.visible = false
	_stage_prelude.visible = true

func _play_stage(data: MenuStageData) -> void:
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
	
	if PersistentPlaySettings.get_mode() == PersistentPlaySettings.CHALLENGE:
		_challenge_record_helper.set_ratings_container(parsed_stage.get_ratings())
		_new_record_strategy = funcref(_challenge_record_helper, "save_new_record")
	else:
		_new_record_strategy = funcref(_arcade_record_helper, "save_new_record")
	
	var game_controller: GameController = GameController.new(
		parsed_stage,
		PersistentPlaySettings.get_mode() == PersistentPlaySettings.CHALLENGE,
		_get_difficulty_settings_values(),
		visual_parameters,
		data.get_uuid(),
		funcref(self, "_back_to_play_menu"),
		_new_record_strategy
	)
	game_view.set_controller(game_controller)
	game_controller.set_view(game_view, scale)
	_main_scene_instance.add_game_controller(game_controller)
	_main_scene_instance.stop_menu_music()
	game_controller.start_new_game()

func _get_difficulty_settings_values() -> DifficultySettings:
	var difficulty: String = PersistentPlaySettings.get_difficulty()
	if difficulty == "Noob": return DifficultySettings.new(12, 0.8, 0.996)
	elif difficulty == "Regular" : return DifficultySettings.new(7, 0.5, 0.99)
	else: return DifficultySettings.new(5, 0.4, 0.984)

func _back_to_play_menu() -> void:
	_main_scene_instance.play_button_click_sound()
	_main_scene_instance.clear()
	_main_scene_instance.add_child(self)
	_main_scene_instance.play_menu_music()
	_populate_stages()
	_play_menu_content.visible = true
	_stage_prelude.visible = false

func _go_to_main_menu() -> void:
	_main_scene_instance.play_button_click_sound()
	_main_menu_scene.initialize(_main_scene_instance)

func _list_available_stages(path: String) -> Array:
	var files = _stages_helper.list_stage_files()
	_stages_data = PersistentStagesData.get_stages()
	_arcade_record_helper = ArcadeRecordHelper.new(_stages_data)
	_challenge_record_helper = ChallengeRecordHelper.new(_stages_data)
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
		var uuid: String = json_data["uuid"]
		var stage_record = null
		var persisted_stars: int = 0
		var is_unlocked: bool = _stages_data.has(uuid)
		if is_unlocked:
			if _stages_data[uuid].get_arcade_record() != null:
				stage_record = _stages_data[uuid].get_arcade_record()
			persisted_stars = _stages_data[uuid].get_stars()
		res.push_back({
			filepath = filepath,
			displayed_name = name,
			uuid = uuid,
			unlocked = is_unlocked,
			record = stage_record,
			stars = persisted_stars
		})
	return res
