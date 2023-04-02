class_name WallView extends Area2D

var _wall_sprite: AnimatedSprite
var _coordinates: Coordinates

func _init(
	coordinates: Coordinates,
	sprite: AnimatedSprite,
	cell_pixels_size: float,
	field_pixels_offset: Vector2
):
	_coordinates = coordinates
	position = PositionCalculator.calculate_position(
		coordinates,
		cell_pixels_size,
		field_pixels_offset
	)
	_wall_sprite = sprite
	add_child(_wall_sprite)

func get_coordinates() -> Coordinates:
	return _coordinates

func play_sprite_animation() -> void:
	_wall_sprite.play()

func stop_sprite_animation() -> void:
	_wall_sprite.stop()
