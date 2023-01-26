extends Area2D

signal snake_head_collision(collidable)

var _coordinates: ImmutablePoint
var _rules
var _game
var _snake
var _visual_parameters

func spawn(
	coordinates: ImmutablePoint,
	rules,
	snake,
	game,
	visual_parameters: VisualParameters
):
	_coordinates = coordinates
	_rules = rules
	_snake = snake
	_game = game
	var px = visual_parameters.get_cell_pixels_size()
	position = Vector2(_coordinates.get_x() * px, _coordinates.get_y() * px)
	var sprite = visual_parameters \
		.get_edible_sprite(_rules.get_type()) \
		.duplicate()
	sprite.set_offset(Vector2(px / 2, px / 2))
	sprite.play()
	add_child(sprite)
	self.connect("snake_head_collision", _snake, "on_collision")

func get_type():
	return _rules.get_type()

func get_coordinates() -> ImmutablePoint:
	return _coordinates

func on_snake_head_collision():
	var should_be_removed = _rules \
		.get_on_head_collision_strategy() \
		.execute(_coordinates, _rules, _snake, _game)
	if should_be_removed:
		self.hide()
		_game.remove_edible(self)

func _on_Node2D_area_entered(area):
	if area == _snake.get_node("Head"):
		emit_signal("snake_head_collision", self)
