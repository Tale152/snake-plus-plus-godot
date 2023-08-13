class_name StageSelectorContainer extends Control

var _StageNameFont = preload("res://src/menu/play_menu_scene/StageNameFont.tres")

var _on_pressed_strategy: FuncRef
var _data: ArcadeStageData

const _DEFAULT_STAGE_NAME_FONT_SIZE: int = 22
const _DEFAULT_MIN_X: int = 282
const _DEFAULT_MIN_Y: int = 120

func initialize(
	on_pressed_strategy: FuncRef,
	text: String,
	data: ArcadeStageData,
	scale: float
) -> void:
	_on_pressed_strategy = on_pressed_strategy
	self.rect_min_size = Vector2(
		_DEFAULT_MIN_X * scale,
		_DEFAULT_MIN_Y * scale
	)
	_StageNameFont.size = _get_int_font_size(_DEFAULT_STAGE_NAME_FONT_SIZE, scale)
	_data = data
	$Button.text = text

func _get_int_font_size(default_value: int, scale: float) -> int:
	return int(floor(default_value * scale))

func _on_Button_pressed():
	_on_pressed_strategy.call_func(_data, $Button.text)
