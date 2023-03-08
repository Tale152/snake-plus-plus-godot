class_name GameInitializationUtils extends Reference

static func init_edibles(edibles_dictionary: Dictionary, edible_rules_array: Array) -> void:
	for r in edible_rules_array:
		edibles_dictionary[r.get_type()] = []

static func init_walls(
	walls_array: Array,
	game,
	points: Array,
	gui_container: Control
) -> void:
	for wp in points:
		var wall = Wall.new(wp, game)
		walls_array.push_back(wall)
		gui_container.add_child(wall)

static func init_background_cells(
	background_cells: Array,
	stage_description: StageDescription,
	visual_parameters: VisualParameters,
	gui_container: Control
) -> void:
	var generated_background_cells = BackgroundGenerator.create_background_cells(
		stage_description, visual_parameters
	)
	for c in generated_background_cells:
		background_cells.push_back(c)
		gui_container.add_child(c)
		c.play_sprite_animation(0.3)

static func init_menu(menu: Control, invoker, scale: float) -> void:
	menu.set_invoker(invoker)
	menu.scale_font(scale)

static func add_controls(controls: Control, gui_container: Control) -> void:
	gui_container.add_child(controls)
	gui_container.move_child(controls, 0)

static func init_hud(hud: Control, scale: float) -> void:
	hud.scale(scale)
