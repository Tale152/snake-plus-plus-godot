class_name WallView extends Area2D

var _wall_sprite: AnimatedSprite
var _coordinates: Coordinates

func _init(
	coordinates: Coordinates,
	connections: CardinalConnections,
	visual_parameters: VisualParameters
):
	_coordinates = coordinates
	position = PositionCalculator.calculate_position(
		coordinates,
		visual_parameters.get_cell_pixels_size(),
		visual_parameters.get_game_pixels_offset()
	)
	_coordinates = coordinates
	_wall_sprite = visual_parameters.get_wall_sprite(connections)
	add_child(_wall_sprite)

func get_coordinates() -> Coordinates:
	return _coordinates

func play_sprite_animation() -> void:
	_wall_sprite.play()

func stop_sprite_animation() -> void:
	_wall_sprite.stop()
