class_name NavigationBar extends Control

onready var _TitleLabelFont = preload("res://src/menu/menu_scene/TitleLabelFont.tres")

var _back_button_pressed_strategy: FuncRef
var _contextual_button_pressed_strategy: FuncRef

func set_on_back_button_pressed_strategy(strategy: FuncRef) -> void:
	_back_button_pressed_strategy = strategy

func set_back_button_visible(flag: bool) -> void:
	$BackButton.visible = flag

func is_back_button_visible() -> bool:
	return $BackButton.visible

func set_back_button_disabled(flag: bool) -> void:
	$BackButton.disabled = flag

func is_back_button_disabled() -> bool:
	return $BackButton.disabled

func set_on_contextual_button_pressed_strategy(strategy: FuncRef) -> void:
	_contextual_button_pressed_strategy = strategy

func set_contextual_button_visible(flag: bool) -> void:
	$ContextualButton.visible = flag

func is_contextual_button_visible() -> bool:
	return $ContextualButton.visible

func set_contextual_button_disabled(flag: bool) -> void:
	$ContextualButton.disabled = flag

func is_contextual_button_disabled() -> bool:
	return $ContextualButton.disabled

func set_title_label_text(text: String) -> void:
	$TitleLabel.text = text

func get_title_label_text() -> String:
	return $TitleLabel.text

func _on_BackButton_pressed():
	_back_button_pressed_strategy.call_func()

func _on_ContextualButton_pressed():
	_contextual_button_pressed_strategy.call_func()
