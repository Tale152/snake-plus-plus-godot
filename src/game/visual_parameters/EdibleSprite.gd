class_name EdibleSprite extends Reference

var _name: String
var _sprite: AnimatedSprite

func _init(path: String, name: String):
	_name = name
	var sprite: AnimatedSprite = AnimatedSprite.new()
	sprite.frames = SpriteFrames.new()
	sprite.frames.add_animation("default")
	var dir = Directory.new()
	var i = 0
	var searching_for_sprites = true
	while searching_for_sprites:
		var f = "/" + name + "_" + str(i) + ".png"
		if dir.file_exists(path + f):
			var img: StreamTexture = load(path + f)
			sprite.frames.add_frame("default", img, i)
			i += 1
		else:
			searching_for_sprites = false
	_sprite = sprite

func get_name() -> String:
	return _name

func get_sprite() -> AnimatedSprite:
	return _sprite
