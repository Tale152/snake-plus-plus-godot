class_name SnakeHeadSprite extends Reference

const DIRECTIONS = preload("res://src/enums/DirectionsEnum.gd").DIRECTIONS

var _direction: int
var _is_tail: bool
var _sprite: AnimatedSprite

func _init(path: String, direction: int, is_tail: bool):
	_direction = direction
	_is_tail = is_tail
	_sprite = AnimationUtils.create_animated_sprite_with_animation("default")
	var name = "head_"
	if _is_tail:
		name += "tail_"
	if direction == DIRECTIONS.UP || direction == DIRECTIONS.DOWN:
		name += "UP"
		_sprite.flip_v = direction == DIRECTIONS.DOWN
	else:
		name += "RIGHT"
		_sprite.flip_h = direction == DIRECTIONS.LEFT
	AnimationUtils.add_frames_to_animation(_sprite.frames, "default", path, name)

func get_direction() -> int:
	return _direction

func is_tail() -> bool:
	return _is_tail

func get_sprite() -> AnimatedSprite:
	return _sprite
