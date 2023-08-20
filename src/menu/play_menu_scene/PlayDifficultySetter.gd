class_name PlayDifficultySetter extends Control

var _DifficultyFont = preload("res://src/menu/play_menu_scene/PlaySettingButtonsFont.tres")

const _DEFAULT_DIFFICULTY_FONT_SIZE: int = 14
const _SELECTED_COLOR: String = "#5bd170"
const _NOT_SELECTED_COLOR: String = "#ffffff"

var _main_scene_instance
var _on_update: FuncRef

func _ready():
	$NoobButton.text = TranslationsManager.get_localized_string(
		TranslationsManager.NOOB
	)
	$RegularButton.text = TranslationsManager.get_localized_string(
		TranslationsManager.REGULAR
	)
	$ProButton.text = TranslationsManager.get_localized_string(
		TranslationsManager.PRO
	)
	var difficulty: String = PersistentPlaySettings.get_difficulty()
	if difficulty == PersistentPlaySettings.NOOB: set_noob_selected()
	elif difficulty == PersistentPlaySettings.REGULAR: set_regular_selected()
	else: set_pro_selected()

func initialize(main_scene_instance, on_update: FuncRef) -> void:
	_main_scene_instance = main_scene_instance
	_on_update = on_update

func scale(scale: float) -> void:
	_DifficultyFont.size = _get_int_font_size(_DEFAULT_DIFFICULTY_FONT_SIZE, scale)

func _get_int_font_size(default_value: int, scale: float) -> int:
	return int(floor(default_value * scale))

func set_noob_selected() -> void:
	if _main_scene_instance != null: _main_scene_instance.play_button_click_sound()
	_adeguate_buttons_color(true, false, false)
	PersistentPlaySettings.set_difficulty(PersistentPlaySettings.NOOB)

func set_regular_selected() -> void:
	if _main_scene_instance != null: _main_scene_instance.play_button_click_sound()
	_adeguate_buttons_color(false, true, false)
	PersistentPlaySettings.set_difficulty(PersistentPlaySettings.REGULAR)

func set_pro_selected() -> void:
	if _main_scene_instance != null: _main_scene_instance.play_button_click_sound()
	_adeguate_buttons_color(false, false, true)
	PersistentPlaySettings.set_difficulty(PersistentPlaySettings.PRO)

func _adeguate_buttons_color(noob: bool, regular: bool, pro: bool) -> void:
	_set_button_color($NoobButton, _SELECTED_COLOR if noob else _NOT_SELECTED_COLOR)
	_set_button_color($RegularButton, _SELECTED_COLOR if regular else _NOT_SELECTED_COLOR)
	_set_button_color($ProButton, _SELECTED_COLOR if pro else _NOT_SELECTED_COLOR)

func _set_button_color(button: Button, color: String) -> void:
	button.add_color_override("font_color", Color(color))
	button.add_color_override("font_color_focus", Color(color))
	button.add_color_override("font_color_hover", Color(color))
	button.add_color_override("font_color_pressed", Color(color))

func _on_NoobButton_pressed():
	set_noob_selected()
	_on_update.call_func()

func _on_RegularButton_pressed():
	set_regular_selected()
	_on_update.call_func()

func _on_ProButton_pressed():
	set_pro_selected()
	_on_update.call_func()
