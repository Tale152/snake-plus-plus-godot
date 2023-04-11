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
	var difficulty_settings: DifficultySettings
	match $GuiAreaControl/RectangleAspectRatioContainer/RectangleControl/SpeedOptionChooser.get_selected_index():
		0: difficulty_settings = DifficultySettings.new(12, 0.6, 0.992)
		1: difficulty_settings = DifficultySettings.new(10, 0.55, 0.991)
		2: difficulty_settings = DifficultySettings.new(7, 0.5, 0.99)
		3: difficulty_settings = DifficultySettings.new(5, 0.45, 0.989)
		4: difficulty_settings = DifficultySettings.new(3, 0.4, 0.988)
	var selected_skin = str(
		"res://assets/skins/", $GuiAreaControl/RectangleAspectRatioContainer/RectangleControl/SkinOptionChooser.get_selected_option()
	)
	var stage_name = $GuiAreaControl/RectangleAspectRatioContainer/RectangleControl/StageOptionChooser.get_selected_option()
	var parsed_stage: ParsedStage = JsonStageParser.parse(str(
		"res://assets/stages/", stage_name, ".json"
	))
	_main.play(parsed_stage, difficulty_settings, selected_skin)

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
