class_name PerkView extends Area2D

var _perk_type: String
var _perk_sprite: AnimatedSprite
var _coordinates: Coordinates

func _init(
	perk_type: String,
	coordinates: Coordinates,
	visual_parameters: VisualParameters
):
	_perk_type = perk_type
	_coordinates = coordinates
	position = PositionCalculator.calculate_position(
		coordinates,
		visual_parameters.get_cell_pixels_size(),
		visual_parameters.get_game_pixels_offset()
	)
	_coordinates = coordinates
	_perk_sprite = visual_parameters.get_perk_sprite(_perk_type)
	add_child(_perk_sprite)

func get_perk_type() -> String:
	return _perk_type

func get_coordinates() -> Coordinates:
	return _coordinates

func play_sprite_animation() -> void:
	_perk_sprite.play()

func stop_sprite_animation() -> void:
	_perk_sprite.stop()
