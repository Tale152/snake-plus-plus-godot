class_name PlayMenuContent extends Control

var _MODES_ARRAY_LOCALIZED: Array = [
	TranslationsManager.get_localized_string(TranslationsManager.CHALLENGE),
	TranslationsManager.get_localized_string(TranslationsManager.ARCADE)
]
var _MODES_ARRAY: Array = [
	PersistentPlaySettings.CHALLENGE,
	PersistentPlaySettings.ARCADE
]
var stages: Array = []

func _ready():
	$ModeOptionChooserControl.fill(
		"Game mode", #TODO localize 
		_MODES_ARRAY_LOCALIZED,
		_get_array_index(_MODES_ARRAY, PersistentPlaySettings.get_mode()),
		funcref(self, "_change_mode")
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
	update_stages()

func scale(scale: float) -> void:
	$PlayDifficultySetterControl.scale(scale)

func initialize(main_scene_instance) -> void:
	$PlayDifficultySetterControl.initialize(main_scene_instance, funcref(self, "update_stages"))

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
