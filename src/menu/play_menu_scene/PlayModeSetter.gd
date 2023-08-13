class_name PlayModeSetter extends Control

var _ModeFont = preload("res://src/menu/play_menu_scene/PlaySettingButtonsFont.tres")

const _DEFAULT_MODE_FONT_SIZE: int = 14
const _SELECTED_COLOR: String = "#5bd170"
const _NOT_SELECTED_COLOR: String = "#ffffff"

var _main_scene_instance

func _ready():
	$ChallengeButton.text = TranslationsManager.get_localized_string(
		TranslationsManager.CHALLENGE
	)
	$ArcadeButton.text = TranslationsManager.get_localized_string(
		TranslationsManager.ARCADE
	)
	var mode: String = PersistentPlaySettings.get_mode()
	if mode == PersistentPlaySettings.CHALLENGE: _on_mode_selected(
		PersistentPlaySettings.CHALLENGE, false
	)
	else: _on_mode_selected(
		PersistentPlaySettings.ARCADE, false
	)

func initialize(main_scene_instance) -> void:
	_main_scene_instance = main_scene_instance

func scale(scale: float) -> void:
	_ModeFont.size = _get_int_font_size(_DEFAULT_MODE_FONT_SIZE, scale)

func _get_int_font_size(default_value: int, scale: float) -> int:
	return int(floor(default_value * scale))

func _on_mode_selected(mode: String, play_audio: bool) -> void:
	if _main_scene_instance != null && play_audio: _main_scene_instance.play_button_click_sound()
	_set_button_color($ChallengeButton, _SELECTED_COLOR if mode == PersistentPlaySettings.CHALLENGE else _NOT_SELECTED_COLOR)
	_set_button_color($ArcadeButton, _SELECTED_COLOR if mode == PersistentPlaySettings.ARCADE else _NOT_SELECTED_COLOR)
	PersistentPlaySettings.set_mode(mode)

func _set_button_color(button: Button, color: String) -> void:
	button.add_color_override("font_color", Color(color))
	button.add_color_override("font_color_focus", Color(color))
	button.add_color_override("font_color_hover", Color(color))
	button.add_color_override("font_color_pressed", Color(color))

func _on_ChallengeButton_pressed():
	_on_mode_selected(PersistentPlaySettings.CHALLENGE, true)

func _on_ArcadeButton_pressed():
	_on_mode_selected(PersistentPlaySettings.ARCADE, true)
