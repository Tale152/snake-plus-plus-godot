class_name SnakeBodySprite extends Reference

const DIRECTIONS = preload("res://src/enums/DirectionsEnum.gd").DIRECTIONS
const DirectionsEnum = preload("res://src/enums/DirectionsEnum.gd")

var _traveling_direction: int
var _back_direction
var _sprite: AnimatedSprite

func _init(path: String, traveling_direction: int, back_direction:int):
	_traveling_direction = traveling_direction
	_back_direction = back_direction
	_sprite = AnimationUtils.create_animated_sprite_with_animation("default")
	var name
	if DirectionsEnum.are_opposite(traveling_direction, back_direction):
		if _traveling_direction == DIRECTIONS.UP || _traveling_direction == DIRECTIONS.DOWN:
			name = "body_STRAIGHT_UP"
			_sprite.flip_v = traveling_direction == DIRECTIONS.DOWN
		else:
			name = "body_STRAIGHT_RIGHT"
			_sprite.flip_h = traveling_direction == DIRECTIONS.LEFT
	else: # diagonal
		if traveling_direction == DIRECTIONS.LEFT || traveling_direction == DIRECTIONS.RIGHT:
			name = "body_DIAGONAL_A"
			_sprite.flip_v = back_direction == DIRECTIONS.DOWN
			_sprite.flip_h = traveling_direction == DIRECTIONS.LEFT
		else:
			name = "body_DIAGONAL_B"
			_sprite.flip_v = traveling_direction == DIRECTIONS.DOWN
			_sprite.flip_h = back_direction == DIRECTIONS.LEFT
	AnimationUtils.add_frames_to_animation(_sprite.frames, "default", path, name)

func get_traveling_direction() -> int:
	return _traveling_direction

func get_back_direction() -> int:
	return _back_direction

func get_sprite() -> AnimatedSprite:
	return _sprite
