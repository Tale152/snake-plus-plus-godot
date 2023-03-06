extends Node

const Menu = preload("res://src/menu/Menu.tscn")
const Game = preload("res://src/game/Game.tscn")

var _menu
var _game
var _is_on_menu
var _pause: bool = false
var _visual_parameters: VisualParameters
var _stage_description: StageDescription

func _init():
	show_menu()
	
func show_menu():
	_is_on_menu = true
	if _game != null:
		remove_child(_game)
		_game = null
	_menu = Menu.instance()
	_menu.set_main(self)
	add_child(_menu)
	_stage_description = null
	_visual_parameters = null

func play(stage_description: StageDescription, visual_parameters_builder: VisualParametersBuilder):
	_is_on_menu = false
	_pause = false
	_stage_description = stage_description
	remove_child(_menu)
	_menu = null
	_game = Game.instance()
	add_child(_game)
	var field_px_size = _game.get_field_px_size()
	var px: int = floor(field_px_size / stage_description.get_field_size().get_width())
	var offset = floor((field_px_size - px * stage_description.get_field_size().get_width()) / 2)
	visual_parameters_builder \
		.set_cell_pixels_size(px) \
		.set_game_pixels_offset(Vector2(offset, offset))
	_visual_parameters = visual_parameters_builder.build()
	_game.initialize(self, stage_description, _visual_parameters)

func _process(delta):
	if !_is_on_menu && !_game.is_game_over() && !_pause:
		_game.tick(delta)

func direction_input(direction: int) -> void:
	_game.direction_input(direction)

func _unhandled_input(event):
	if Input.is_action_pressed("back_to_menu") && !_is_on_menu:
		show_menu()
	else:
		var direction: int = -1
		if event is InputEventKey:
			direction = KeyMovementInput.get_input_direction()
		if direction != -1 && !_is_on_menu:
			self.direction_input(direction)

func change_pause_status() -> void:
	_pause = !_pause

func restart() -> void:
	if _game != null:
		remove_child(_game)
		_game = null
	_is_on_menu = false
	_pause = false
	remove_child(_game)
	_game = Game.instance()
	add_child(_game)
	_game.initialize(self, _stage_description, _visual_parameters)
