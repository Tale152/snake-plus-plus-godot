extends Area2D

signal snake_head_collision(collidable)

var _placement: ImmutablePoint
var _rules
var _game
var _snake
var _visual_parameters

func spawn(
	placement: ImmutablePoint,
	rules,
	snake,
	game,
	visual_parameters: VisualParameters
):
	_placement = placement
	_rules = rules
	_snake = snake
	_game = game
	var px = visual_parameters.get_cell_pixels_size()
	position = Vector2(placement.get_x() * px, placement.get_y() * px)
	var sprite = visual_parameters.get_sprite(_rules.get_type()).duplicate()
	sprite.set_offset(Vector2(px / 2, px / 2))
	add_child(sprite)
	self.connect("snake_head_collision", _snake, "on_collision")

func get_type():
	return _rules.get_type()

func get_placement() -> ImmutablePoint:
	return _placement

func on_snake_head_collision():
	var should_be_removed = _rules \
		.get_on_head_collision_strategy() \
		.execute(_placement, _rules, _snake, _game)
	if should_be_removed:
		self.hide()
		_game.remove_edible(self)

func _on_Node2D_area_entered(area):
	if area == _snake.get_node("Head"):
		emit_signal("snake_head_collision", self)
