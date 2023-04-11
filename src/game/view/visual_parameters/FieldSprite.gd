class_name FieldSprite extends Reference

var _sprite: AnimatedSprite

func _init(path: String, name: String):
	_sprite = AnimationUtils.create_animated_sprite_with_animation()
	AnimationUtils.add_frames_to_animation(_sprite.frames, "default", path, name)

func get_sprite() -> AnimatedSprite:
	return _sprite
