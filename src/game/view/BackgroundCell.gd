class_name BackgroundCell extends Area2D

var _cell_sprite: AnimatedSprite
var _coordinates: Coordinates

func _init(
	sprite: AnimatedSprite,
	coordinates: Coordinates,
	cell_pixels_size: float,
	field_pixels_offset: Vector2
):
	_coordinates = coordinates
	position = PositionCalculator.calculate_position(
		coordinates,
		cell_pixels_size,
		field_pixels_offset
	)
	_cell_sprite = sprite
	add_child(_cell_sprite)
	
func get_coordinates() -> Coordinates:
	return _coordinates

func play_sprite_animation(speed_scale: float) -> void:
	_cell_sprite.speed_scale = speed_scale
	_cell_sprite.play()

func stop_sprite_animation() -> void:
	_cell_sprite.stop()
