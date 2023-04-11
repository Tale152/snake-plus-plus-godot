class_name SnakeBodySprite extends Reference

var _traveling_direction: int
var _back_direction
var _sprite: AnimatedSprite

func _init(path: String, traveling_direction: int, back_direction:int):
	_traveling_direction = traveling_direction
	_back_direction = back_direction
	_sprite = AnimationUtils.create_animated_sprite_with_animation()
	var name
	if Direction.are_opposite(traveling_direction, back_direction):
		if _traveling_direction == Direction.UP() || _traveling_direction == Direction.DOWN():
			name = "body_STRAIGHT_UP"
			_sprite.flip_v = traveling_direction == Direction.DOWN()
		else:
			name = "body_STRAIGHT_RIGHT"
			_sprite.flip_h = traveling_direction == Direction.LEFT()
	else: # diagonal
		if traveling_direction == Direction.LEFT() || traveling_direction == Direction.RIGHT():
			name = "body_DIAGONAL_A"
			_sprite.flip_v = back_direction == Direction.DOWN()
			_sprite.flip_h = traveling_direction == Direction.LEFT()
		else:
			name = "body_DIAGONAL_B"
			_sprite.flip_v = traveling_direction == Direction.DOWN()
			_sprite.flip_h = back_direction == Direction.LEFT()
	AnimationUtils.add_frames_to_animation(_sprite.frames, "default", path, name)

func get_traveling_direction() -> int:
	return _traveling_direction

func get_back_direction() -> int:
	return _back_direction

func get_sprite() -> AnimatedSprite:
	return _sprite
