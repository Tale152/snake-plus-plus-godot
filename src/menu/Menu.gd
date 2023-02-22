extends Control

var _main

static func TOP_HUD_HEIGHT_PX() -> int:
	return int(OS.window_size.y * 0.15)

func _ready():
	$SpeedContainer/SpeedItemList.select(2)
	$SkinContainer/SkinItemList.select(0)
	for stage in _list_available_stages("res://assets/stages"):
		$StageContainer/StageItemList.add_item(stage)
	$StageContainer/StageItemList.select(0)

func set_main(main) -> void:
	_main = main

func _on_PlayButton_pressed():
	var description_builder = StageDescriptionBuilder.new()
	match $SpeedContainer/SpeedItemList.get_selected_items()[0]:
		0: description_builder.set_snake_speedup_factor(0.992).set_snake_base_delta_seconds(0.6)
		1: description_builder.set_snake_speedup_factor(0.991).set_snake_base_delta_seconds(0.55)
		2: description_builder.set_snake_speedup_factor(0.99).set_snake_base_delta_seconds(0.5)
		3: description_builder.set_snake_speedup_factor(0.989).set_snake_base_delta_seconds(0.45)
		4: description_builder.set_snake_speedup_factor(0.988).set_snake_base_delta_seconds(0.4)
	var selected_skin = str(
		"res://assets/skins/", $SkinContainer/SkinItemList.get_item_text($SkinContainer/SkinItemList.get_selected_items()[0])
	)
	var visual_parameters_builder = VisualParametersBuilder.new()
	visual_parameters_builder \
		.set_snake_skin_path(str(selected_skin, "/snake")) \
		.set_field_elements_skin_path(str(selected_skin, "/field"))
	var stage_index = $StageContainer/StageItemList.get_selected_items()[0]
	var stage_name = $StageContainer/StageItemList.get_item_text(stage_index)
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
	_set_px(visual_parameters_builder, parsed_stage.get_field_size().get_width(), parsed_stage.get_field_size().get_height())
	_main.play(description_builder.build(), visual_parameters_builder.build())

static func _set_px(
	visual_parameters_builder: VisualParametersBuilder,
	width: int,
	height: int
) -> void:
	var width_px = int(OS.window_size.x / width)
	var heigh_px = int((OS.window_size.y - TOP_HUD_HEIGHT_PX())/ height)
	var cell_px_size = width_px if width_px < heigh_px else heigh_px
	visual_parameters_builder \
		.set_cell_pixels_size(cell_px_size) \
		.set_game_pixels_offset(Vector2(
			(OS.window_size.x - width * cell_px_size) / 2,
			TOP_HUD_HEIGHT_PX()
		))

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
