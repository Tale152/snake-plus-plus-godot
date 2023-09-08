class_name StagePreludeScene extends Control

const _StagePreludeContent = preload("res://src/menu/stage_prelude_menu/StagePreludeContent.tscn")
const _GameView = preload("res://src/game/view/GameView.tscn")

onready var _NavigationBar: NavigationBar = $MenuSceneControl.get_navigation_bar()
var _stage_prelude_content: StagePreludeContent = _StagePreludeContent.instance()

var _main_scene_instance: Control
var _main_menu_scene
var _previous_scene
var _new_record_strategy: FuncRef
var _arcade_record_helper: ArcadeRecordHelper
var _challenge_record_helper: ChallengeRecordHelper

func _ready():
	_NavigationBar.set_title_label_text("")
	_NavigationBar.set_left_button_visible(true, "back")
	_NavigationBar.set_left_button_disabled(false)
	_NavigationBar.set_on_left_button_pressed_strategy(funcref(self, "_go_to_previous_scene"))
	_NavigationBar.set_right_button_visible(false)
	_NavigationBar.set_right_button_disabled(true)
	_stage_prelude_content.anchor_left = 0
	_stage_prelude_content.anchor_right = 1
	_stage_prelude_content.anchor_top = 0
	_stage_prelude_content.anchor_bottom = 1
	$MenuSceneControl._ContentContainerControl.add_child(_stage_prelude_content)

func initialize_by_play_menu(
	main_scene_instance: Control,
	main_menu_scene,
	play_menu_scene,
	data: MenuStageData,
	name: String
) -> void:
	_main_scene_instance = main_scene_instance
	_main_menu_scene = main_menu_scene
	_previous_scene = play_menu_scene
	_stage_prelude_content.initialize(
		data, name, funcref(self, "_play_stage")
	)
	_main_scene_instance.clear()
	_main_scene_instance.add_child(self)
	_stage_prelude_content.scale($MenuSceneControl.get_scaling())

func _go_to_previous_scene() -> void:
	_previous_scene.initialize(_main_scene_instance, _main_menu_scene)

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
		_challenge_record_helper = ChallengeRecordHelper.new(PersistentStagesData.get_stages())
		_challenge_record_helper.set_ratings_container(parsed_stage.get_ratings())
		_new_record_strategy = funcref(_challenge_record_helper, "save_new_record")
	else:
		_arcade_record_helper = ArcadeRecordHelper.new(PersistentStagesData.get_stages())
		_new_record_strategy = funcref(_arcade_record_helper, "save_new_record")
	
	var game_controller: GameController = GameController.new(
		parsed_stage,
		PersistentPlaySettings.get_mode() == PersistentPlaySettings.CHALLENGE,
		_get_difficulty_settings_values(),
		visual_parameters,
		data.get_uuid(),
		funcref(self, "_go_to_previous_scene"),
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
