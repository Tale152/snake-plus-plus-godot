extends Area2D

signal snake_head_collision(collidable)

var _placement: ImmutablePoint
var _rules: InstantaneousEdibleRules
var _game
var _snake

func get_type():
	return InstantaneousEdiblesTypes.BAD_APPLE()

func spawn(
	placement: ImmutablePoint,
	rules: InstantaneousEdibleRules,
	snake,
	game,
	visual_parameters: VisualParameters
):
	_placement = placement
	_rules
	_snake = snake
	_game = game
	var px = visual_parameters.get_cell_pixels_size()
	position = Vector2(placement.get_x() * px, placement.get_y() * px)
	self.connect("snake_head_collision", _snake, "on_collision")

func get_placement() -> ImmutablePoint:
	return _placement

func _on_BadApple_area_entered(area):
	if area == _snake.get_node("Head"):
		emit_signal("snake_head_collision", self)
		self.hide()
		_game.remove_edible(self)

func on_snake_head_collision():
	if _snake.properties.potential_length > 1:
		_snake.properties.potential_length -= 1
