class_name SettingsMenuContent extends Control

onready var _MusicFont = preload("res://src/menu/settings_menu_scene/MusicFont.tres")
onready var _EffectsFont = preload("res://src/menu/settings_menu_scene/EffectsFont.tres")

const _CONTROLS_ARRAY: Array = ["Swipe", "Arrow", "Split"]
const _SLIDERS_DEFAULT_FONT_SIZE: int = 18
var _main_scene_instance
var _change_language_parent_strategy: FuncRef

func _ready():
	$ControlsOptionChooser.fill(
		TranslationsManager.get_localized_string(TranslationsManager.CONTROLS), 
		_CONTROLS_ARRAY,
		_get_array_index(_CONTROLS_ARRAY, PersistentUserSettings.get_controls()),
		funcref(self, "_change_controls")
	)
	$MusicLabel.text = TranslationsManager.get_localized_string(
		TranslationsManager.MUSIC
	)
	$MusicHSlider.value = PersistentUserSettings.get_music_bus_volume()
	$EffectsLabel.text = TranslationsManager.get_localized_string(
		TranslationsManager.EFFECTS
	)
	$EffectsHSlider.value = PersistentUserSettings.get_effects_bus_volume()
	$LanguageOptionChooser.fill(
		TranslationsManager.get_localized_string(TranslationsManager.LANGUAGE),
		TranslationsManager.get_supported_languages().keys(),
		_get_array_index(
			TranslationsManager.get_supported_languages().values(),
			PersistentUserSettings.get_language()
		),
		funcref(self, "_change_language")
	)

func scale(scale: float) -> void:
	$ControlsOptionChooser.scale_font(scale)
	_MusicFont.size = _get_int_font_size(_SLIDERS_DEFAULT_FONT_SIZE, scale)
	_EffectsFont.size = _get_int_font_size(_SLIDERS_DEFAULT_FONT_SIZE, scale)

func initialize(main_scene_instance) -> void:
	_main_scene_instance  = main_scene_instance

func _change_controls(controls: String) -> void:
	_main_scene_instance.play_button_click_sound()
	PersistentUserSettings.set_controls(controls)

func set_change_language_parent_strategy(strategy: FuncRef) -> void:
	_change_language_parent_strategy = strategy

func _change_language(language: String) -> void:
	for supported in TranslationsManager.get_supported_languages().keys():
		if supported == language:
			PersistentUserSettings.set_language(
				TranslationsManager.get_supported_languages()[supported]
			)
			_main_scene_instance.play_button_click_sound()
			_change_language_parent_strategy.call_func()
			_ready()

func _get_array_index(arr: Array, elem) -> int:
	var i = 0
	for v in arr:
		if elem == v: return i
		i += 1
	return 0

func _get_int_font_size(default_value: int, scale: float) -> int:
	return int(floor(default_value * scale))

func _on_MusicHSlider_value_changed(value: int) -> void:
	PersistentUserSettings.set_music_bus_volume(value)

func _on_EffectsHSlider_value_changed(value):
	PersistentUserSettings.set_effects_bus_volume(value)
