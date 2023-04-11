class_name SnakeTailSprite extends Reference

var _direction: int
var _sprite: AnimatedSprite

func _init(path: String, direction: int):
	_direction = direction
	_sprite = AnimationUtils.create_animated_sprite_with_animation()
	var name
	if direction == Direction.UP() || direction == Direction.DOWN():
		name = "tail_UP"
		_sprite.flip_v = direction == Direction.DOWN()
	else:
		name = "tail_RIGHT"
		_sprite.flip_h = direction == Direction.LEFT()
	AnimationUtils.add_frames_to_animation(_sprite.frames, "default", path, name)

func get_direction() -> int:
	return _direction

func get_sprite() -> AnimatedSprite:
	return _sprite
