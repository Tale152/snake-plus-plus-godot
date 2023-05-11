class_name NavigationBar extends Control

onready var _TitleLabelFont = preload("res://src/menu/menu_scene/TitleLabelFont.tres")

const _TITLE_FONT_DEFAULT_SIZE: int = 25

var _trophy_icon_path = "res://assets/icons/trophy.png"
var _settings_icon_path = "res://assets/icons/settings.png"
var _back_icon_path = "res://assets/icons/back.png"
var _info_icon_path = "res://assets/icons/info.png"

var _left_button_pressed_strategy: FuncRef
var _right_button_pressed_strategy: FuncRef

func scale(scale: int) -> void:
	_TitleLabelFont.size = _TITLE_FONT_DEFAULT_SIZE * scale

func set_on_left_button_pressed_strategy(strategy: FuncRef) -> void:
	_left_button_pressed_strategy = strategy

func set_left_button_visible(flag: bool, icon: String = "") -> void:
	$LeftButton.visible = flag
	if(icon != ""): $LeftButton.icon = _get_button_image_texture(icon)

func is_left_button_visible() -> bool:
	return $LeftButton.visible

func set_left_button_disabled(flag: bool) -> void:
	$LeftButton.disabled = flag

func is_left_button_disabled() -> bool:
	return $LeftButton.disabled

func set_on_right_button_pressed_strategy(strategy: FuncRef) -> void:
	_right_button_pressed_strategy = strategy

func set_right_button_visible(flag: bool, icon: String = "") -> void:
	$RightButton.visible = flag
	if(icon != ""): $RightButton.icon = _get_button_image_texture(icon)

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

func _get_button_image_texture(icon: String) -> ImageTexture:
	var path: String
	if icon == "trophy": path = _trophy_icon_path
	elif icon == "settings": path = _settings_icon_path
	elif icon == "back": path = _back_icon_path
	elif icon == "info": path = _info_icon_path
	
	var image = Image.new()
	image.load(path)
	var t = ImageTexture.new()
	t.create_from_image(image)
	return t

func _on_RightButton_pressed():
	_right_button_pressed_strategy.call_func()

func _on_LeftButton_pressed():
	_left_button_pressed_strategy.call_func()
