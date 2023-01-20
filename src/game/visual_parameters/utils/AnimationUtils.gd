class_name AnimationUtils extends Reference

static func create_animated_sprite_with_animation(animation_name: String) -> AnimatedSprite:
	var sprite: AnimatedSprite = AnimatedSprite.new()
	sprite.frames = SpriteFrames.new()
	sprite.frames.add_animation(animation_name)
	return sprite

static func add_frames_to_animation(
	frames: SpriteFrames,
	animation_name: String,
	frame_path: String,
	frame_name: String
):
	var i = 0
	while true:
		var f = AssetFiles.build_asset_path(frame_path, frame_name, i)
		if AssetFiles.asset_exists(f):
			frames.add_frame(animation_name, AssetFiles.load_asset(f), i)
			i += 1
		else:
			return
