class_name BackgroundCell extends Area2D

var _cell_sprite: AnimatedSprite
var _coordinates: Coordinates

func _init(
	coordinates: Coordinates,
	visual_parameters: VisualParameters
):
	_coordinates = coordinates
	position = PositionCalculator.calculate_position(
		coordinates,
		visual_parameters.get_cell_pixels_size(),
		visual_parameters.get_game_pixels_offset()
	)
	_cell_sprite = _get_random_background_cell_sprite(visual_parameters)
	add_child(_cell_sprite)

func _get_random_background_cell_sprite(
	visual_parameters: VisualParameters
) -> AnimatedSprite:
	var background_cells_sprites = visual_parameters.get_background_sprites()
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var rnd_i = rng.randi() % background_cells_sprites.size()
	return background_cells_sprites[rnd_i].duplicate()

func get_coordinates() -> Coordinates:
	return _coordinates

func play_sprite_animation() -> void:
	_cell_sprite.play()

func stop_sprite_animation() -> void:
	_cell_sprite.stop()
