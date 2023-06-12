extends Control

const _MainMenuScene = preload("res://src/menu/main_menu_scene/MainMenuScene.tscn")

const _ACTION_BACK_TO_MENU: String = "back_to_menu"
const _ACTION_MOVE_RIGHT: String = "move_right"
const _ACTION_MOVE_LEFT: String = "move_left"
const _ACTION_MOVE_UP: String = "move_up"
const _ACTION_MOVE_DOWN: String = "move_down"

onready var _MusicLoop: AudioStreamPlayer = $MenuMusicAudioStreamPlayer
onready var _ButtonClick: AudioStreamPlayer = $ButtonClickAudioStreamPlayer
var _game_controller: GameController = null
var _process_strategy: FuncRef = null
var _unhandled_input_strategy: FuncRef = null

func _ready():
	PersistentUserSettings.set_music_bus_volume(
		PersistentUserSettings.get_music_bus_volume()
	)
	PersistentUserSettings.set_effects_bus_volume(
		PersistentUserSettings.get_effects_bus_volume()
	)
	PersistentUserSettings.set_language(PersistentUserSettings.get_language())
	_process_strategy = funcref(self, "_menu_loop")
	_unhandled_input_strategy = funcref(self, "_menu_unhandled_input")
	var main_menu_scene = _MainMenuScene.instance()
	main_menu_scene.initialize(self)
	_MusicLoop.play()

func _process(delta):
	_process_strategy.call_func(delta)

func _unhandled_input(event):
	_unhandled_input_strategy.call_func(event)

func clear() -> void:
	_process_strategy = funcref(self, "_menu_loop")
	_unhandled_input_strategy = funcref(self, "_menu_unhandled_input")
	_game_controller = null
	var i = 0
	for n in get_children():
		if i != 0 && i != 1: remove_child(n)
		i += 1

func play_menu_music() -> void:
	_MusicLoop.play()

func stop_menu_music() -> void:
	_MusicLoop.stop()

func play_button_click_sound() -> void:
	_ButtonClick.play()

func add_game_controller(game_controller: GameController) -> void:
	_game_controller = game_controller
	_unhandled_input_strategy = funcref(self, "_playing_unhandled_input")
	_process_strategy = funcref(self, "_playing_loop")
	
func _playing_loop(delta) -> void:
	if _game_controller.is_not_game_over():
		_game_controller.tick(delta)

func _menu_loop(_delta) -> void:
	pass

func _playing_unhandled_input(_event) -> void:
	if Input.is_action_pressed(_ACTION_MOVE_UP): _game_controller.direction_input(Direction.UP())
	elif Input.is_action_pressed(_ACTION_MOVE_DOWN): _game_controller.direction_input(Direction.DOWN())
	elif Input.is_action_pressed(_ACTION_MOVE_LEFT): _game_controller.direction_input(Direction.LEFT())
	elif Input.is_action_pressed(_ACTION_MOVE_RIGHT): _game_controller.direction_input(Direction.RIGHT())
	elif Input.is_action_pressed(_ACTION_BACK_TO_MENU): _game_controller._exit_game_strategy.call_func()
	
func _menu_unhandled_input(event) -> void:
	pass
