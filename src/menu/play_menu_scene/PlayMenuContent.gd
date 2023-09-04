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
	$OptionsContainerControl/ModeOptionChooserControl.fill(
		TranslationsManager.get_localized_string(TranslationsManager.GAME_MODE),
		_MODES_ARRAY_LOCALIZED,
		_get_array_index(_MODES_ARRAY, PersistentPlaySettings.get_mode()),
		funcref(self, "_change_mode")
	)
	$OptionsContainerControl/DifficultyOptionChooserControl.fill(
		TranslationsManager.get_localized_string(TranslationsManager.DIFFICULTY),
		_DIFFICULTY_ARRAY_LOCALIZED,
		_get_array_index(_DIFFICULTY_ARRAY, PersistentPlaySettings.get_difficulty()),
		funcref(self, "_change_difficulty")
	)
	_handle_scroll_arrows()

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
	$OptionsContainerControl/SummaryDisplayControl.update()

func _change_difficulty(difficulty_localized: String) -> void:
	PersistentPlaySettings.set_difficulty(
		_DIFFICULTY_ARRAY[_get_array_index(_DIFFICULTY_ARRAY_LOCALIZED, difficulty_localized)]
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
	stages.push_back(stage)
	$StagesContainerControl/ScrollContainer/VBoxContainer.add_child(stage)
	return stages.size() - 1

func clear_stages() -> void:
	for stage in stages:
		$StagesContainerControl/ScrollContainer/VBoxContainer.remove_child(stage)
	stages = []

func update_stages() -> void:
	for stage in stages:
		stage.update_container()

func _on_ScrollContainer_scroll_ended():
	_handle_scroll_arrows()

func _on_ScrollContainer_scroll_started():
	_handle_scroll_arrows()

func _on_ScrollContainer_gui_input(_event):
	_handle_scroll_arrows()

func _handle_scroll_arrows() -> void:
	var max_scroll_value = $StagesContainerControl/ScrollContainer.get_v_scrollbar().max_value - $StagesContainerControl/ScrollContainer.rect_size.y
	var scroll_value = $StagesContainerControl/ScrollContainer.get_v_scrollbar().value
	_handle_arrows_disabled(
		scroll_value == 0,
		scroll_value == max_scroll_value
	)

func _handle_arrows_disabled(up: bool, down: bool) -> void:
	$StagesContainerControl/UpperLimitControl/ScrollUpTextureButton.visible = !up
	$StagesContainerControl/UpperLimitControl/ScrollUpTextureButton.disabled = up
	$StagesContainerControl/LowerLimitControl/ScrollDownTextureButton.visible = !down
	$StagesContainerControl/LowerLimitControl/ScrollDownTextureButton.disabled = down
