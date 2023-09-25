
class_name ParametersInfo extends Control

var _greater_than_equals_icon = preload("res://assets/icons/greater_than_equals.png")
var _equals_icon = preload("res://assets/icons/equals.png")
var _less_than_icon = preload("res://assets/icons/less_than.png")
var _like_icon = preload("res://assets/icons/like.png")

const _DEFAULT_LABEL_SIZE: int = 20
const _DEFAULT_LABEL_OUTLINE_SIZE: int = 2

const GREATER_THAN_EQUALS: int = 0
const EQUALS: int = 1
const LESS_THAN: int = 2
const LIKE: int = 3

func scale_text(scale: float) -> void:
	_scale_text_helper($SnakeLabel, scale)
	_scale_text_helper($ScoreLabel, scale)
	_scale_text_helper($TimeLabel, scale)

func _scale_text_helper(label: Label, scale: float) -> void:
	ScalingHelper.scale_text_and_outline(
		label, _DEFAULT_LABEL_SIZE, _DEFAULT_LABEL_OUTLINE_SIZE, scale
	)

func set_snake(icon: int, text: String = "") -> void:
	_alter_icons($SnakeCriteriaTextureButton, icon)
	$SnakeLabel.text = text

func set_score(icon: int, text: String = "") -> void:
	_alter_icons($ScoreCriteriaTextureButton, icon)
	$ScoreLabel.text = text

func set_time(icon: int, text: String = "") -> void:
	_alter_icons($TimeCriteriaTextureButton, icon)
	$TimeLabel.text = text

func _alter_icons(
	criteria_texture_button: TextureButton, criteria_icon: int
) -> void:
	if criteria_icon == GREATER_THAN_EQUALS:
		criteria_texture_button.texture_normal = _greater_than_equals_icon
	elif criteria_icon == EQUALS:
		criteria_texture_button.texture_normal = _equals_icon
	elif criteria_icon == LESS_THAN:
		criteria_texture_button.texture_normal = _less_than_icon
	elif criteria_icon == LIKE:
		criteria_texture_button.texture_normal = _like_icon
