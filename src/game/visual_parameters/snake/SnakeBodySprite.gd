class_name SnakeBodySprite extends Reference

const DIRECTIONS = preload("res://src/enums/DirectionsEnum.gd").DIRECTIONS
const DirectionsEnum = preload("res://src/enums/DirectionsEnum.gd")

var _traveling_direction: int
var _back_direction
var _sprite: AnimatedSprite

func _init(path: String, traveling_direction: int, back_direction:int):
	_traveling_direction = traveling_direction
	_back_direction = back_direction
	var sprite: AnimatedSprite = AnimatedSprite.new()
	sprite.frames = SpriteFrames.new()
	sprite.frames.add_animation("default")
	var name
	if DirectionsEnum.are_opposite(traveling_direction, back_direction):
		name = _build_straight_body_name()
		sprite.flip_v = traveling_direction == DIRECTIONS.DOWN
		sprite.flip_h = traveling_direction == DIRECTIONS.LEFT
	else:
		if traveling_direction == DIRECTIONS.LEFT || traveling_direction == DIRECTIONS.RIGHT:
			name = "body_DIAGONAL_A"
			sprite.flip_v = back_direction == DIRECTIONS.DOWN
			sprite.flip_h = traveling_direction == DIRECTIONS.LEFT
		else:
			name = "body_DIAGONAL_B"
			sprite.flip_v = traveling_direction == DIRECTIONS.DOWN
			sprite.flip_h = back_direction == DIRECTIONS.LEFT
	var i = 0
	var searching_for_sprites = true
	while searching_for_sprites:
		var f = AssetFiles.build_asset_path(path, name, i)
		if AssetFiles.asset_exists(f):
			sprite.frames.add_frame("default", AssetFiles.load_asset(f), i)
			i += 1
		else:
			searching_for_sprites = false
	_sprite = sprite

func get_traveling_direction() -> int:
	return _traveling_direction

func get_back_direction() -> int:
	return _back_direction

func get_sprite() -> AnimatedSprite:
	return _sprite

func _build_straight_body_name() -> String:
	if _traveling_direction == DIRECTIONS.UP || _traveling_direction == DIRECTIONS.DOWN:
		return "body_STRAIGHT_UP"
	else:
		return "body_STRAIGHT_RIGHT"
