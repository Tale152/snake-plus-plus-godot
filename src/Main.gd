extends Node

const Menu = preload("res://src/menu/Menu.tscn")
const GameView = preload("res://src/game/view/GameView.tscn")
const ArrowsControls = preload("res://src/game/view/controls/arrows_controls/ArrowsControls.tscn")

var _menu
var _game_controller: GameController
var _game_view
var _arrows_controls: ArrowsControls
var _is_on_menu

func _init():
	show_menu()

func get_scale() -> float:
	var project_height = ProjectSettings.get("display/window/size/height")
	var project_width = ProjectSettings.get("display/window/size/width")
	var original_ratio = project_height / project_width
	var screen_size = get_tree().get_root().size
	var runtime_ratio = screen_size.y / screen_size.x
	if runtime_ratio >= original_ratio:
		return screen_size.x / project_width
	else:
		return screen_size.y / project_height

func show_menu():
	_is_on_menu = true
	_menu = Menu.instance()
	_menu.set_main(self)
	add_child(_menu)

func play(parsed_stage: ParsedStage, difficulty_settings: DifficultySettings):
	_is_on_menu = false
	_game_controller = GameController.new(parsed_stage, difficulty_settings)
	_arrows_controls = ArrowsControls.instance()
	_game_view = GameView.instance()
	if _menu != null:
		remove_child(_menu)
		_menu = null
	add_child(_game_view)
	_game_view.set_controls(_arrows_controls)
	_game_view.set_controller(_game_controller)
	_game_controller.set_view(_game_view)

func _process(delta):
	pass
	#if !_is_on_menu && !_game.is_game_over() && !_pause:
		#_game.tick(delta)

func _unhandled_input(event):
	if Input.is_action_pressed("back_to_menu") && !_is_on_menu:
		show_menu()
