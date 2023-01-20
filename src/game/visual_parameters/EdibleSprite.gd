class_name EdibleSprite extends Reference

var _name: String
var _sprite: AnimatedSprite

func _init(path: String, name: String):
	_name = name
	_sprite = AnimationUtils.create_animated_sprite_with_animation()
	AnimationUtils.add_frames_to_animation(_sprite.frames, "default", path, name)

func get_name() -> String:
	return _name

func get_sprite() -> AnimatedSprite:
	return _sprite
