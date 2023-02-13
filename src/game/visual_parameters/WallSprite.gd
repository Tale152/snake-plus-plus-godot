class_name WallSprite extends Reference

var _sprite: AnimatedSprite
var _cardinal_connections: CardinalConnections

func _init(path: String, cardinal_connections: CardinalConnections):
	_cardinal_connections = cardinal_connections
	_sprite = AnimationUtils.create_animated_sprite_with_animation()
	var name = str(
		"Wall_",
		_direction_to_binary(Directions.get_up()),
		_direction_to_binary(Directions.get_right()),
		_direction_to_binary(Directions.get_down()),
		_direction_to_binary(Directions.get_left())
	)
	AnimationUtils.add_frames_to_animation(_sprite.frames, "default", path, name)

func get_sprite() -> AnimatedSprite:
	return _sprite

func _direction_to_binary(direction: int) -> String:
	return "1" if _cardinal_connections.is_connected_to(direction) else "0"

