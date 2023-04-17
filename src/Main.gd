extends Node

const Menu = preload("res://src/menu/Menu.tscn")
const GameView = preload("res://src/game/view/GameView.tscn")
const ArrowsControls = preload("res://src/game/view/controls/arrows_controls/ArrowsControls.tscn")

const _ACTION_MOVE_RIGHT: String = "move_right"
const _ACTION_MOVE_LEFT: String = "move_left"
const _ACTION_MOVE_UP: String = "move_up"
const _ACTION_MOVE_DOWN: String = "move_down"

var _menu
var _game_controller: GameController
var _game_view
var _arrows_controls: ArrowsControls
var _is_outside_menu

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
	_is_outside_menu = false
	if _game_view != null:
		remove_child(_game_view)
		_game_view = null
		_game_controller = null
	_menu = Menu.instance()
	_menu.set_main(self)
	add_child(_menu)

func play(
	parsed_stage: ParsedStage,
	difficulty_settings: DifficultySettings,
	selected_skin: String
):
	_is_outside_menu = true
	_arrows_controls = ArrowsControls.instance()
	_game_view = GameView.instance()
	if _menu != null:
		remove_child(_menu)
		_menu = null
	add_child(_game_view)
	var visual_parameters: VisualParameters = get_visual_parameters(
		selected_skin,
		_game_view.get_field_px_size(get_scale()),
		parsed_stage
	)
	_game_controller = GameController.new(
		parsed_stage, difficulty_settings, visual_parameters, funcref(self, "show_menu")
	)
	_game_view.set_controls(_arrows_controls)
	_game_view.set_controller(_game_controller)
	_game_controller.set_view(_game_view)
	_game_controller.start_new_game()

func get_visual_parameters(
	selected_skin: String,
	field_px_size: int,
	parsed_stage: ParsedStage
) -> VisualParameters:
	var px: int = floor(field_px_size / parsed_stage.get_field_width())
	var offset = floor((field_px_size - px * parsed_stage.get_field_width()) / 2)
	var vpb: VisualParametersBuilder = VisualParametersBuilder.new()
	for p in parsed_stage.get_perks_rules():
		vpb.add_perk_sprite(
			PerkSprite.new(
				str(selected_skin, "/edibles"), #TODO change
				p.get_type()
		))
	vpb \
		.set_snake_skin_path(str(selected_skin, "/snake")) \
		.set_field_elements_skin_path(str(selected_skin, "/field")) \
		.set_cell_pixels_size(px) \
		.set_game_pixels_offset(Vector2(offset, offset))
	return vpb.build()

func _process(delta):
	if _is_outside_menu && _game_controller.is_not_game_over():
		_game_controller.tick(delta)

func _unhandled_input(event):
	if Input.is_action_pressed("back_to_menu") && _is_outside_menu:
		show_menu()
	else:
		if Input.is_action_pressed(_ACTION_MOVE_UP): _game_controller.direction_input(Direction.UP())
		elif Input.is_action_pressed(_ACTION_MOVE_DOWN): _game_controller.direction_input(Direction.DOWN())
		elif Input.is_action_pressed(_ACTION_MOVE_LEFT): _game_controller.direction_input(Direction.LEFT())
		elif Input.is_action_pressed(_ACTION_MOVE_RIGHT): _game_controller.direction_input(Direction.RIGHT())
