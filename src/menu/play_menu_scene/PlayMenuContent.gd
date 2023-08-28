class_name PlayMenuContent extends Control

var _MODES_ARRAY_LOCALIZED: Array = [
	TranslationsManager.get_localized_string(TranslationsManager.CHALLENGE),
	TranslationsManager.get_localized_string(TranslationsManager.ARCADE)
]
var _MODES_ARRAY: Array = [
	PersistentPlaySettings.CHALLENGE,
	PersistentPlaySettings.ARCADE
]
var _DIFFICULTY_ARRAY_LOCALIZED: Array = [
	TranslationsManager.get_localized_string(TranslationsManager.REGULAR),
	TranslationsManager.get_localized_string(TranslationsManager.PRO)
]
var _DIFFICULTY_ARRAY: Array = [
	PersistentPlaySettings.REGULAR,
	PersistentPlaySettings.PRO
]
var stages: Array = []
var _main_menu_scene

func _ready():
	$ModeOptionChooserControl.fill(
		TranslationsManager.get_localized_string(TranslationsManager.GAME_MODE),
		_MODES_ARRAY_LOCALIZED,
		_get_array_index(_MODES_ARRAY, PersistentPlaySettings.get_mode()),
		funcref(self, "_change_mode")
	)
	$DifficultyOptionChooserControl.fill(
		TranslationsManager.get_localized_string(TranslationsManager.DIFFICULTY),
		_DIFFICULTY_ARRAY_LOCALIZED,
		_get_array_index(_DIFFICULTY_ARRAY, PersistentPlaySettings.get_difficulty()),
		funcref(self, "_change_difficulty")
	)

func _get_array_index(arr: Array, elem) -> int:
	var i = 0
	for v in arr:
		if elem == v: return i
		i += 1
	return 0

func _change_mode(mode_localized: String) -> void:
	PersistentPlaySettings.set_mode(
		_MODES_ARRAY[_get_array_index(_MODES_ARRAY_LOCALIZED, mode_localized)]
	)
	_main_menu_scene.play_button_click_sound()
	update_stages()

func _change_difficulty(difficulty_localized: String) -> void:
	PersistentPlaySettings.set_difficulty(
		_DIFFICULTY_ARRAY[_get_array_index(_DIFFICULTY_ARRAY_LOCALIZED, difficulty_localized)]
	)
	_main_menu_scene.play_button_click_sound()
	update_stages()

func scale(scale: float) -> void:
	pass

func initialize(main_scene_instance) -> void:
	_main_menu_scene = main_scene_instance

func append_stage(stage) -> int:
	stages.push_back(stage)
	$ScrollContainer/VBoxContainer.add_child(stage)
	return stages.size() - 1

func clear_stages() -> void:
	for stage in stages:
		$ScrollContainer/VBoxContainer.remove_child(stage)
	stages = []

func update_stages() -> void:
	for stage in stages:
		stage.update_container()
