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

func play(stage_description: StageDescription, visual_parameters: VisualParameters):
	_is_on_menu = false
	_pause = false
	_stage_description = stage_description
	_visual_parameters = visual_parameters
	remove_child(_menu)
	_menu = null
	_game = Game.instance()
	_game.initialize(self, stage_description, visual_parameters)
	add_child(_game)

func _process(delta):
	if !_is_on_menu:
		if !_game.is_game_over():
			if !_pause:
				_game.tick(delta)
				for t in _game.get_snake().get_effects_timers():
					print(str(t.get_effect_type(), " ", t.get_elapsed_time(), "/", t.get_total_time()))
		else:
			yield(get_tree().create_timer(3.0), "timeout")
			show_menu()

func _unhandled_input(event):
	if Input.is_action_pressed("back_to_menu") && !_is_on_menu:
		show_menu()
	else:
		var direction: int = -1
		if event is InputEventScreenDrag:
			direction = SwipeMovementInput.get_input_direction(event) 
		elif event is InputEventKey:
			direction = KeyMovementInput.get_input_direction()
		if direction != -1 && !_is_on_menu:
			_game.direction_input(direction)

func change_pause_status() -> void:
	_pause = !_pause

func restart() -> void:
	_is_on_menu = false
	_pause = false
	remove_child(_game)
	_game = Game.instance()
	_game.initialize(self, _stage_description, _visual_parameters)
	add_child(_game)
