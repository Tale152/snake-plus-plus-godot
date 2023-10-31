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
var _main_menu_scene

func _ready():
	$OptionsContainerControl/ModeOptionChooserControl.fill(
		TranslationsManager.get_localized_string(TranslationsManager.GAME_MODE),
		_MODES_ARRAY_LOCALIZED,
		ArrayUtils.get_array_index(_MODES_ARRAY, PersistentPlaySettings.get_mode()),
		funcref(self, "_change_mode")
	)
	$OptionsContainerControl/DifficultyOptionChooserControl.fill(
		TranslationsManager.get_localized_string(TranslationsManager.DIFFICULTY),
		_DIFFICULTY_ARRAY_LOCALIZED,
		ArrayUtils.get_array_index(_DIFFICULTY_ARRAY, PersistentPlaySettings.get_difficulty()),
		funcref(self, "_change_difficulty")
	)
	$ScrollableContainerControl.initialize()

func _change_mode(mode_localized: String) -> void:
	PersistentPlaySettings.set_mode(
		_MODES_ARRAY[ArrayUtils.get_array_index(_MODES_ARRAY_LOCALIZED, mode_localized)]
	)
	_main_menu_scene.play_button_click_sound()
	update_stages()
	$OptionsContainerControl/SummaryDisplayControl.update()

func _change_difficulty(difficulty_localized: String) -> void:
	PersistentPlaySettings.set_difficulty(
		_DIFFICULTY_ARRAY[ArrayUtils.get_array_index(_DIFFICULTY_ARRAY_LOCALIZED, difficulty_localized)]
	)
	_main_menu_scene.play_button_click_sound()
	update_stages()
	$OptionsContainerControl/SummaryDisplayControl.update()

func scale(scale: float) -> void:
	$OptionsContainerControl/ModeOptionChooserControl.scale_font(scale)
	$OptionsContainerControl/DifficultyOptionChooserControl.scale_font(scale)
	$OptionsContainerControl/SummaryDisplayControl.scale_font(scale)

func initialize(main_scene_instance) -> void:
	_main_menu_scene = main_scene_instance
	$OptionsContainerControl/SummaryDisplayControl.update()

func refresh_data() -> void:
	$OptionsContainerControl/SummaryDisplayControl.update()

func append_stage(stage) -> int:
	return $ScrollableContainerControl.append_content(stage)

func clear_stages() -> void:
	$ScrollableContainerControl.clear_content()

func update_stages() -> void:
	var s: FuncRef = funcref(self, "_update_container")
	$ScrollableContainerControl.update_content(s)

func _update_container(stage) -> void:
	stage.update_container()
