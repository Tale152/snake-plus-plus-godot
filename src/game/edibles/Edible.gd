class_name Edible extends Area2D

var _coordinates: ImmutablePoint
var _rules: EdibleRules
var _game
var _snake
var _visual_parameters

func _init(
	coordinates: ImmutablePoint,
	rules: EdibleRules,
	snake,
	game,
	visual_parameters: VisualParameters
):
	_coordinates = coordinates
	_rules = rules
	_snake = snake
	_game = game
	position = PositionCalculator.calculate_position(
		_coordinates,
		visual_parameters.get_cell_pixels_size(),
		visual_parameters.get_game_pixels_offset()
	)
	var sprite = visual_parameters.get_edible_sprite(_rules.get_type())
	sprite.play()
	add_child(sprite)

func get_type() -> String:
	return _rules.get_type()

func get_coordinates() -> ImmutablePoint:
	return _coordinates

func on_snake_head_collision() -> void:
	var has_to_be_removed = _rules.get_on_head_collision_strategy().execute(
		_coordinates, _rules, _snake, _game
	)
	if has_to_be_removed:
		self.hide()
		_game.remove_edible(self)
