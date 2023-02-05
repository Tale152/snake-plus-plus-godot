extends Node

const Menu = preload("res://src/menu/Menu.tscn")

var _menu
var _game
var _is_on_menu

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

func play(stage_description: StageDescription, visual_parameters: VisualParameters):
	_is_on_menu = false
	remove_child(_menu)
	_menu = null
	_game = Game.new(stage_description, visual_parameters)
	add_child(_game)

func _process(delta):
	if !_is_on_menu && !_game.is_game_over():
		_game.tick(delta)

func _unhandled_input(event):
	if Input.is_action_pressed("back_to_menu") && !_is_on_menu:
		show_menu()
	else:
		var direction: int = -1
		if event is InputEventScreenDrag:
			direction = SwipeMovementInput.get_input_direction(event) 
		elif event is InputEventKey:
			direction = KeyMovementInput.get_input_direction()
		if direction != -1:
			_game.direction_input(direction)
