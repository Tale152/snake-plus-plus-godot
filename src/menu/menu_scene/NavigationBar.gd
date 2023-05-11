class_name NavigationBar extends Control

onready var _TitleLabelFont = preload("res://src/menu/menu_scene/TitleLabelFont.tres")

var _left_button_pressed_strategy: FuncRef
var _right_button_pressed_strategy: FuncRef

func set_on_left_button_pressed_strategy(strategy: FuncRef) -> void:
	_left_button_pressed_strategy = strategy

func set_left_button_visible(flag: bool) -> void:
	$LeftButton.visible = flag

func is_left_button_visible() -> bool:
	return $LeftButton.visible

func set_left_button_disabled(flag: bool) -> void:
	$LeftButton.disabled = flag

func is_left_button_disabled() -> bool:
	return $LeftButton.disabled

func set_on_right_button_pressed_strategy(strategy: FuncRef) -> void:
	_right_button_pressed_strategy = strategy

func set_right_button_visible(flag: bool) -> void:
	$RightButton.visible = flag

func is_right_button_visible() -> bool:
	return $RightButton.visible

func set_right_button_disabled(flag: bool) -> void:
	$RightButton.disabled = flag

func is_right_button_disabled() -> bool:
	return $RightButton.disabled

func set_title_label_text(text: String) -> void:
	$TitleLabel.text = text

func get_title_label_text() -> String:
	return $TitleLabel.text

func _on_RightButton_pressed():
	_right_button_pressed_strategy.call_func()

func _on_LeftButton_pressed():
	_left_button_pressed_strategy.call_func()
