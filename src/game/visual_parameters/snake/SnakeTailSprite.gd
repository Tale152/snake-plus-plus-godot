class_name SnakeTailSprite extends Reference

const DIRECTIONS = preload("res://src/enums/DirectionsEnum.gd").DIRECTIONS

var _direction: int
var _sprite: AnimatedSprite

func _init(path: String, direction: int):
	_direction = direction
	_sprite = AnimationUtils.create_animated_sprite_with_animation("default")
	var name
	if direction == DIRECTIONS.UP || direction == DIRECTIONS.DOWN:
		name = "tail_UP"
		_sprite.flip_v = direction == DIRECTIONS.DOWN
	else:
		name = "tail_RIGHT"
		_sprite.flip_h = direction == DIRECTIONS.LEFT
	AnimationUtils.add_frames_to_animation(_sprite.frames, "default", path, name)

func get_direction() -> int:
	return _direction

func get_sprite() -> AnimatedSprite:
	return _sprite
