class_name ArcadeDifficultySetter extends Control

var _DifficultyFont = preload("res://src/menu/arcade_menu_scene/DifficultyFont.tres")

const _DEFAULT_DIFFICULTY_FONT_SIZE: int = 14
const _SELECTED_COLOR: String = "#5bd170"
const _NOT_SELECTED_COLOR: String = "#ffffff"

var _main_scene_instance

func _ready():
	var difficulty: String = PersistentDifficultySettings.get_arcade_difficulty()
	if difficulty == "Noob": set_noob_selected()
	elif difficulty == "Regular": set_regular_selected()
	else: set_pro_selected()

func initialize(main_scene_instance) -> void:
	_main_scene_instance = main_scene_instance

func scale(scale: float) -> void:
	_DifficultyFont.size = _get_int_font_size(_DEFAULT_DIFFICULTY_FONT_SIZE, scale)

func _get_int_font_size(default_value: int, scale: float) -> int:
	return int(floor(default_value * scale))

func set_noob_selected() -> void:
	if _main_scene_instance != null: _main_scene_instance.play_button_click_sound()
	_adeguate_buttons_color(true, false, false)
	PersistentDifficultySettings.set_arcade_difficulty("Noob")

func set_regular_selected() -> void:
	if _main_scene_instance != null: _main_scene_instance.play_button_click_sound()
	_adeguate_buttons_color(false, true, false)
	PersistentDifficultySettings.set_arcade_difficulty("Regular")

func set_pro_selected() -> void:
	if _main_scene_instance != null: _main_scene_instance.play_button_click_sound()
	_adeguate_buttons_color(false, false, true)
	PersistentDifficultySettings.set_arcade_difficulty("Pro")

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

func _on_RegularButton_pressed():
	set_regular_selected()

func _on_ProButton_pressed():
	set_pro_selected()
