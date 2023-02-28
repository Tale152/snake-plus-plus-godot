extends Control

onready var _TitleLabelFont = preload("res://src/menu/OptionChooserTitleFont.tres")
onready var _SelectedOptionLabelFont = preload("res://src/menu/OptionChooserSelectedOptionFont.tres")
onready var _PreviousButtonFont = preload("res://src/menu/OptionChooserPreviousFont.tres")
onready var _NextButtonFont = preload("res://src/menu/OptionChooserNextFont.tres")

const _TITLE_LABEL_DEFAULT_FONT_SIZE: int = 23
const _SELECTED_OPTION_LABEL_DEFAULT_FONT_SIZE: int = 16
const _BUTTONS_DEFAULT_FONT_SIZE: int = 17

var _options: Array
var _selected_index: int

func fill(title: String, options: Array, selected_index: int) -> void:
	$TitleLabel.text = title
	_options = options
	_selected_index = selected_index
	_update_selected_option()

func scale_font(scale: float) -> void:
	_TitleLabelFont.size = _get_int_font_size(_TITLE_LABEL_DEFAULT_FONT_SIZE, scale)
	_SelectedOptionLabelFont.size = _get_int_font_size(_SELECTED_OPTION_LABEL_DEFAULT_FONT_SIZE, scale)
	_PreviousButtonFont.size = _get_int_font_size(_BUTTONS_DEFAULT_FONT_SIZE, scale)
	_NextButtonFont.size = _get_int_font_size(_BUTTONS_DEFAULT_FONT_SIZE, scale)

func get_options() -> Array:
	return _options

func get_title() -> String:
	return $TitleLabel.text

func get_selected_index() -> int:
	return _selected_index

func get_selected_option() -> String:
	return _options[_selected_index]

func _on_PreviousOptionButton_pressed():
	_selected_index -= 1
	if _selected_index < 0: _selected_index = _options.size() - 1
	_update_selected_option()

func _on_NextOptionButton_pressed():
	_selected_index += 1
	if _selected_index == _options.size(): _selected_index = 0
	_update_selected_option()

func _get_int_font_size(default_value: int, scale: float) -> int:
	return int(floor(_TITLE_LABEL_DEFAULT_FONT_SIZE * scale))

func _update_selected_option() -> void:
	$SelectedOptionLabel.text = _options[_selected_index]
