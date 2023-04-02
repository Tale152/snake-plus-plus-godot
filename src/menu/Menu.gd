extends Control

onready var PlayButtonFont = preload("res://src/menu/PlayButtonFont.tres")
onready var GameTitleFont = preload("res://src/menu/GameTitleFont.tres")

var _main

const SPEED_ARRAY: Array = ["very slow", "slow", "normal", "fast", "very fast"]
const SPEED_DEFAULT_INDEX: int = 2
const SKINS_ARRAY: Array = ["simple", "debug", "kawaii"]
const SKINS_DEFAULT_INDEX: int = 0
const GAME_TITLE_DEFAULT_FONT_SIZE: int = 40
const PLAY_BUTTON_DEFAULT_FONT_SIZE: int = 28

func _ready():
	var scale = _get_scale()
	GameTitleFont.size = _get_int_font_size(GAME_TITLE_DEFAULT_FONT_SIZE, scale)
	PlayButtonFont.size = _get_int_font_size(PLAY_BUTTON_DEFAULT_FONT_SIZE, scale)
	$GuiAreaControl/RectangleAspectRatioContainer/RectangleControl/SpeedOptionChooser.fill(
		"Speed", SPEED_ARRAY, SPEED_DEFAULT_INDEX
	)
	$GuiAreaControl/RectangleAspectRatioContainer/RectangleControl/SpeedOptionChooser.scale_font(scale)
	$GuiAreaControl/RectangleAspectRatioContainer/RectangleControl/SkinOptionChooser.fill(
		"Skin", SKINS_ARRAY, SKINS_DEFAULT_INDEX
	)
	$GuiAreaControl/RectangleAspectRatioContainer/RectangleControl/SkinOptionChooser.scale_font(scale)
	$GuiAreaControl/RectangleAspectRatioContainer/RectangleControl/StageOptionChooser.fill(
		"Stage", _list_available_stages("res://assets/stages"), 0
	)
	$GuiAreaControl/RectangleAspectRatioContainer/RectangleControl/StageOptionChooser.scale_font(scale)

func _get_int_font_size(default_value: int, scale: float) -> int:
	return int(floor(default_value * scale))

func set_main(main) -> void:
	_main = main

func _get_scale() -> float:
	var project_height = ProjectSettings.get("display/window/size/height")
	var project_width = ProjectSettings.get("display/window/size/width")
	var original_ratio = project_height / project_width
	var screen_size = get_tree().get_root().size
	var runtime_ratio = screen_size.y / screen_size.x
	if runtime_ratio >= original_ratio:
		return screen_size.x / project_width
	else:
		return screen_size.y / project_height

func _on_PlayButton_pressed():
	var description_builder = StageDescriptionBuilder.new()
	match $GuiAreaControl/RectangleAspectRatioContainer/RectangleControl/SpeedOptionChooser.get_selected_index():
		0: description_builder.set_snake_speedup_factor(0.992).set_snake_base_delta_seconds(0.6)
		1: description_builder.set_snake_speedup_factor(0.991).set_snake_base_delta_seconds(0.55)
		2: description_builder.set_snake_speedup_factor(0.99).set_snake_base_delta_seconds(0.5)
		3: description_builder.set_snake_speedup_factor(0.989).set_snake_base_delta_seconds(0.45)
		4: description_builder.set_snake_speedup_factor(0.988).set_snake_base_delta_seconds(0.4)
	var selected_skin = str(
		"res://assets/skins/", $GuiAreaControl/RectangleAspectRatioContainer/RectangleControl/SkinOptionChooser.get_selected_option()
	)
	var visual_parameters_builder = VisualParametersBuilder.new()
	visual_parameters_builder \
		.set_snake_skin_path(str(selected_skin, "/snake")) \
		.set_field_elements_skin_path(str(selected_skin, "/field"))
	var stage_name = $GuiAreaControl/RectangleAspectRatioContainer/RectangleControl/StageOptionChooser.get_selected_option()
	var parsed_stage: ParsedStage = JsonStageParser.parse(str(
		"res://assets/stages/", stage_name, ".json"
	))
	description_builder \
		.set_field_size(parsed_stage.get_field_size()) \
		.set_snake_spawn_point(parsed_stage.get_snake_spawn_point()) \
		.set_snake_initial_direction(parsed_stage.get_snake_initial_direction()) \
		.set_walls_points(parsed_stage.get_walls_points())
	for e in parsed_stage.get_edible_rules():
		description_builder.add_edible_rules(e)
		visual_parameters_builder \
			.add_edible_sprite(
				EdibleSprite.new(
					str(selected_skin, "/edibles"),
					e.get_type()
			)
		)
	_main.play(description_builder.build(), visual_parameters_builder)

func _list_available_stages(path: String) -> Array:
	var files = _list_files_in_directory(path)
	var res = []
	for f in files:
		res.push_back(f.replace(".json", ""))
	return res

func _list_files_in_directory(path):
	var files = []
	var dir = Directory.new()
	dir.open(path)
	dir.list_dir_begin()

	while true:
		var file = dir.get_next()
		if file == "":
			break
		elif not file.begins_with("."):
			files.append(file)

	dir.list_dir_end()

	return files
