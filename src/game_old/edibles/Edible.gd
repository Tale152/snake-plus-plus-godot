class_name Edible extends Area2D

var _coordinates: ImmutablePoint
var _rules: EdibleRules
var _life_span: float
var _can_expire: bool
var _game
var _snake
var _visual_parameters
var _sprite: AnimatedSprite
var _elapsed_time: float = 0

func _init(
	coordinates: ImmutablePoint,
	rules: EdibleRules,
	snake,
	game,
	visual_parameters: VisualParameters
):
	_coordinates = coordinates
	_rules = rules
	_life_span = _rules.get_life_span()
	_can_expire = _life_span != -1
	_snake = snake
	_game = game
	position = PositionCalculator.calculate_position(
		_coordinates,
		visual_parameters.get_cell_pixels_size(),
		visual_parameters.get_game_pixels_offset()
	)
	_sprite = visual_parameters.get_edible_sprite(_rules.get_type())
	_sprite.play()
	add_child(_sprite)

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

func start_sprite_animation() -> void:
	_sprite.play()

func stop_sprite_animation() -> void:
	_sprite.stop()

func tick(delta_second: float) -> void:
	_elapsed_time += delta_second

func is_expired() -> bool:
	return _elapsed_time >= _life_span if _can_expire else false
