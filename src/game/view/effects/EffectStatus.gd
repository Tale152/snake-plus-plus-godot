class_name EffectStatus extends Control

const _SPRITE_SIDE_PROPORTION: float = 0.68
const _GREEN_PERCENTAGE_TRESHOLD: int = 50
const _YELLOW_PERCENTAGE_TRESHOLD: int = 20
const _GREEN: Color = Color("41d426")
const _YELLOW: Color = Color("f5e506")
const _RED: Color = Color("cb1515")
const _DEFAULT_WINDOW_WIDTH: int = 300
const _DEFAULT_SPRITE_X: int = 48
const _DEFAULT_SPRITE_Y: int = 15

onready var _progress_bar_foreground = $RemainingTimeProgressBar.get("custom_styles/fg")

var _sprite: AnimatedSprite
var _current_percentage: int =  -1

func initialize(sprite: AnimatedSprite, side_size_px: int):
	self.anchor_top = 0
	self.anchor_bottom = 1
	_sprite = sprite
	add_child(_sprite)
	_scale_sprite(sprite, side_size_px)

func render(anchor_l: float, anchor_r: float, percentage: int) -> void:
	self.anchor_left = anchor_l
	self.anchor_right = anchor_r
	_current_percentage = percentage
	$RemainingTimeProgressBar.value = percentage
	_set_remaining_time_progress_bar_color(percentage)

func get_current_percentage() -> int:
	return _current_percentage

func start_sprite_animation() -> void:
	_sprite.play()

func stop_sprite_animation() -> void:
	_sprite.stop()

func _scale_sprite(sprite: AnimatedSprite, side_size_px: int) -> void:
	var height: float = float(sprite.get_sprite_frames().get_frame("default",0).get_height())
	var scale: float = (float(side_size_px)  * _SPRITE_SIDE_PROPORTION) / height
	sprite.set_scale(Vector2(scale, scale))
	var position_scale = (_DEFAULT_WINDOW_WIDTH / side_size_px)
	sprite.position = Vector2(
		_DEFAULT_SPRITE_X / position_scale,
		_DEFAULT_SPRITE_Y / position_scale
	)

func _set_remaining_time_progress_bar_color(percentage: int) -> void:
	if percentage > _GREEN_PERCENTAGE_TRESHOLD:
		_progress_bar_foreground.set_bg_color(_GREEN)
	elif percentage > _YELLOW_PERCENTAGE_TRESHOLD:
		_progress_bar_foreground.set_bg_color(_YELLOW)
	else:
		_progress_bar_foreground.set_bg_color(_RED)
