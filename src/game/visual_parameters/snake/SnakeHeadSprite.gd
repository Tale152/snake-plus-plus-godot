class_name SnakeHeadSprite extends Reference

const DIRECTIONS = preload("res://src/enums/DirectionsEnum.gd").DIRECTIONS

var _direction: int
var _is_tail: bool
var _sprite: AnimatedSprite

func _init(path: String, direction: int, is_tail: bool):
	_direction = direction
	_is_tail = is_tail
	var sprite: AnimatedSprite = AnimatedSprite.new()
	sprite.frames = SpriteFrames.new()
	sprite.frames.add_animation("default")
	var name = "head_"
	if _is_tail:
		name += "tail_"
	if direction == DIRECTIONS.UP || direction == DIRECTIONS.DOWN:
		name += "UP"
	else:
		name += "RIGHT"
	var i = 0
	var searching_for_sprites = true
	while searching_for_sprites:
		var f = AssetFiles.build_asset_path(path, name, i)
		if AssetFiles.asset_exists(f):
			sprite.frames.add_frame("default", AssetFiles.load_asset(f), i)
			i += 1
		else:
			searching_for_sprites = false
	if direction == DIRECTIONS.DOWN:
		sprite.flip_v = true
	elif direction == DIRECTIONS.LEFT:
		sprite.flip_h = true
	_sprite = sprite

func get_direction() -> int:
	return _direction

func is_tail() -> bool:
	return _is_tail

func get_sprite() -> AnimatedSprite:
	return _sprite
