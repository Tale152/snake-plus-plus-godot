extends Control

onready var _TitleLabelFont = preload("res://src/menu/OptionChooserTitleFont.tres")
onready var _SelectedOptionLabelFont = preload("res://src/menu/OptionChooserSelectedOptionFont.tres")

const _TITLE_LABEL_DEFAULT_FONT_SIZE: int = 14
const _SELECTED_OPTION_LABEL_DEFAULT_FONT_SIZE: int = 17
const _BUTTONS_DEFAULT_FONT_SIZE: int = 17
const _DEFAULT_WAVE_AMP: int = 6

var _options: Array
var _selected_index: int
var _on_change_strategy: FuncRef
var _wave_amp: int = _DEFAULT_WAVE_AMP

func fill(
	title: String,
	options: Array,
	selected_index: int,
	on_change_strategy: FuncRef
) -> void:
	$TitleLabel.text = title
	_options = options
	_selected_index = selected_index
	_on_change_strategy = on_change_strategy
	_update_selected_option()

func scale_font(scale: float) -> void:
	_wave_amp = _get_int_font_size(_DEFAULT_WAVE_AMP, scale)
	_TitleLabelFont.size = _get_int_font_size(_TITLE_LABEL_DEFAULT_FONT_SIZE, scale)
	_SelectedOptionLabelFont.size = _get_int_font_size(_SELECTED_OPTION_LABEL_DEFAULT_FONT_SIZE, scale)
	$SelectedOptionLabel.add_font_override("normal_font", _SelectedOptionLabelFont)

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
	_on_change_strategy.call_func(get_selected_option())

func _on_NextOptionButton_pressed():
	_selected_index += 1
	if _selected_index == _options.size(): _selected_index = 0
	_update_selected_option()
	_on_change_strategy.call_func(get_selected_option())

func _get_int_font_size(default_value: int, scale: float) -> int:
	return int(floor(default_value * scale))

func _update_selected_option() -> void:
	$SelectedOptionLabel.bbcode_text = "[center][wave amp=" + str(_wave_amp) + "]" + _options[_selected_index] + "[/wave][/center]"
