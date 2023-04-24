class_name Hud extends Control

const _FONT_DEFAULT_SIZE: int = 17
const _SCORE_SPRITE_DEFAULT_POSITION: Vector2 = Vector2(15, 15)
const _LENGTH_SPRITE_DEFAULT_POSITION: Vector2 = Vector2(162, 15)
const _TIME_SPRITE_DEFAULT_POSITION: Vector2 = Vector2(224, 15)
onready var _time_label_font = preload("res://src/game/view/hud/TimeLabel.tres")
onready var _score_label_font = preload("res://src/game/view/hud/ScoreLabel.tres")
onready var _length_label_font = preload("res://src/game/view/hud/LengthLabel.tres")

func scale(scale: float) -> void:
	var font_size = int(floor(_FONT_DEFAULT_SIZE * scale))
	_scale_info($ScoreAnimatedSprite, scale, _SCORE_SPRITE_DEFAULT_POSITION, _score_label_font, font_size)
	_scale_info($LengthAnimatedSprite, scale, _LENGTH_SPRITE_DEFAULT_POSITION, _length_label_font, font_size)
	_scale_info($TimeAnimatedSprite, scale, _TIME_SPRITE_DEFAULT_POSITION, _time_label_font, font_size)

func _scale_info(
	sprite: AnimatedSprite,
	scale: float,
	default_position: Vector2,
	font,
	font_size: int
) -> void:
	var sprite_source_size = sprite.get_sprite_frames().get_frame("default",0).get_width()
	var basic_scaling = 1 / (sprite_source_size / 25.0)
	var window_scaling = scale * basic_scaling
	sprite.set_scale(Vector2(window_scaling, window_scaling))
	sprite.position = Vector2(default_position.x * scale, default_position.y * scale)
	font.size = font_size

func update_values(score: int, length: int, seconds: float) -> void:
	$ScoreLabel.text = str(score)
	$LengthLabel.text = str(length)
	$TimeLabel.text = _get_time_text(seconds)

func play_animations() -> void:
	$ScoreAnimatedSprite.play()
	$LengthAnimatedSprite.play()
	$TimeAnimatedSprite.play()

func stop_animations() -> void:
	$ScoreAnimatedSprite.stop()
	$LengthAnimatedSprite.stop()
	$TimeAnimatedSprite.stop()

func _get_time_text(seconds: float) -> String:
	var s = floor(seconds)
	var time_text = ""
	if s < 60:
		return str("0:", s if s > 9 else str(0, s))
	else:
		var minutes = floor(s / 60)
		s = s - minutes * 60
		return str(minutes, ":", s if s > 9 else str(0, s))
