class_name DevMenuStages extends Reference

static func TOP_HUD_HEIGHT_PX() -> int:
	return int(OS.window_size.y * 0.1)

static func complete_builders(
	stage_description_builder: StageDescriptionBuilder,
	visual_parameters_builder: VisualParametersBuilder,
	edibles_skin_path: String,
	stage_index: int
) -> void:
	match stage_index:
		0: _complete_0(stage_description_builder, visual_parameters_builder, edibles_skin_path)
		1: _complete_1(stage_description_builder, visual_parameters_builder, edibles_skin_path)
		2: _complete_2(stage_description_builder, visual_parameters_builder, edibles_skin_path)

static func _complete_0(
	stage_description_builder: StageDescriptionBuilder,
	visual_parameters_builder: VisualParametersBuilder,
	edibles_skin_path: String
) -> void:
	var width = 16
	var heigh = 16
	stage_description_builder \
		.set_field_size(FieldSize.new(width, heigh)) \
		.set_snake_spawn_point(ImmutablePoint.new(1,1)) \
		.set_snake_initial_direction(Directions.get_right()) \
		.set_walls_points([
			ImmutablePoint.new(0, 0),
			ImmutablePoint.new(1, 0),
			ImmutablePoint.new(0, 1),
			ImmutablePoint.new(0, 14),
			ImmutablePoint.new(1, 15),
			ImmutablePoint.new(0, 15),
			ImmutablePoint.new(14, 0),
			ImmutablePoint.new(15, 0),
			ImmutablePoint.new(15, 1),
			ImmutablePoint.new(15, 15),
			ImmutablePoint.new(15, 14),
			ImmutablePoint.new(14, 15),
			ImmutablePoint.new(7, 7),
			ImmutablePoint.new(7, 8),
			ImmutablePoint.new(8, 7),
			ImmutablePoint.new(8, 8),
		]) \
		.add_edible_rules(
			EdibleRulesBuiler.new() \
				.set_type(EdibleTypes.APPLE()) \
				.set_max_instances(7) \
				.set_life_spawn(-1) \
				.set_spawn_locations([]) \
				.set_spawn_probability(1) \
				.build()
		) \
		.add_edible_rules(
			EdibleRulesBuiler.new() \
				.set_type(EdibleTypes.ORANGE()) \
				.set_max_instances(1) \
				.set_life_spawn(7) \
				.set_spawn_locations([]) \
				.set_spawn_probability(0.5) \
				.build()
		) \
		.add_edible_rules(
			EdibleRulesBuiler.new() \
				.set_type(EdibleTypes.CHERRY()) \
				.set_max_instances(1) \
				.set_life_spawn(-1) \
				.set_spawn_locations([]) \
				.set_spawn_probability(0.25) \
				.build()
		) \
		.add_edible_rules(
			EdibleRulesBuiler.new() \
				.set_type(EdibleTypes.GAIN_COIN()) \
				.set_max_instances(3) \
				.set_life_spawn(5) \
				.set_spawn_locations([]) \
				.set_spawn_probability(0.2) \
				.build()
		)
	visual_parameters_builder \
		.add_edible_sprite(EdibleSprite.new(edibles_skin_path, EdibleTypes.APPLE())) \
		.add_edible_sprite(EdibleSprite.new(edibles_skin_path, EdibleTypes.ORANGE())) \
		.add_edible_sprite(EdibleSprite.new(edibles_skin_path, EdibleTypes.CHERRY())) \
		.add_edible_sprite(EdibleSprite.new(edibles_skin_path, EdibleTypes.GAIN_COIN()))
	_set_px(visual_parameters_builder, width, heigh)

static func _complete_1(
	stage_description_builder: StageDescriptionBuilder,
	visual_parameters_builder: VisualParametersBuilder,
	edibles_skin_path: String
) -> void:
	var width = 15
	var heigh = 11
	stage_description_builder \
		.set_field_size(FieldSize.new(width, heigh)) \
		.set_snake_spawn_point(ImmutablePoint.new(7,5)) \
		.set_snake_initial_direction(Directions.get_down()) \
		.add_edible_rules(
			EdibleRulesBuiler.new() \
				.set_type(EdibleTypes.APPLE()) \
				.set_max_instances(5) \
				.set_life_spawn(-1) \
				.set_spawn_locations([]) \
				.set_spawn_probability(0.9) \
				.build()
		) \
		.add_edible_rules(
			EdibleRulesBuiler.new() \
				.set_type(EdibleTypes.CHERRY()) \
				.set_max_instances(1) \
				.set_life_spawn(-1) \
				.set_spawn_locations([]) \
				.set_spawn_probability(0.25) \
				.build()
		) \
		.add_edible_rules(
			EdibleRulesBuiler.new() \
				.set_type(EdibleTypes.BAD_APPLE()) \
				.set_max_instances(3) \
				.set_life_spawn(-1) \
				.set_spawn_locations([]) \
				.set_spawn_probability(0.6) \
				.build()
		) \
		.add_edible_rules(
			EdibleRulesBuiler.new() \
				.set_type(EdibleTypes.GAIN_COIN()) \
				.set_max_instances(3) \
				.set_life_spawn(3) \
				.set_spawn_locations([]) \
				.set_spawn_probability(0.2) \
				.build()
		) \
		.add_edible_rules(
			EdibleRulesBuiler.new() \
				.set_type(EdibleTypes.LOSS_COIN()) \
				.set_max_instances(3) \
				.set_life_spawn(3) \
				.set_spawn_locations([]) \
				.set_spawn_probability(0.4) \
				.build()
		)
	visual_parameters_builder \
		.add_edible_sprite(EdibleSprite.new(edibles_skin_path, EdibleTypes.APPLE())) \
		.add_edible_sprite(EdibleSprite.new(edibles_skin_path, EdibleTypes.CHERRY())) \
		.add_edible_sprite(EdibleSprite.new(edibles_skin_path, EdibleTypes.BAD_APPLE())) \
		.add_edible_sprite(EdibleSprite.new(edibles_skin_path, EdibleTypes.GAIN_COIN())) \
		.add_edible_sprite(EdibleSprite.new(edibles_skin_path, EdibleTypes.LOSS_COIN()))
	_set_px(visual_parameters_builder, width, heigh)

static func _complete_2(
	stage_description_builder: StageDescriptionBuilder,
	visual_parameters_builder: VisualParametersBuilder,
	edibles_skin_path: String
) -> void:
	var width = 15
	var heigh = 11
	stage_description_builder \
		.set_field_size(FieldSize.new(width, heigh)) \
		.set_snake_spawn_point(ImmutablePoint.new(7,6)) \
		.set_snake_initial_direction(Directions.get_down()) \
		.add_edible_rules(
			EdibleRulesBuiler.new() \
				.set_type(EdibleTypes.APPLE()) \
				.set_max_instances(5) \
				.set_life_spawn(5) \
				.set_spawn_locations([]) \
				.set_spawn_probability(0.9) \
				.build()
		) \
		.add_edible_rules(
			EdibleRulesBuiler.new() \
				.set_type(EdibleTypes.CHERRY()) \
				.set_max_instances(1) \
				.set_life_spawn(5) \
				.set_spawn_locations([]) \
				.set_spawn_probability(0.25) \
				.build()
		) \
		.add_edible_rules(
			EdibleRulesBuiler.new() \
				.set_type(EdibleTypes.BAD_APPLE()) \
				.set_max_instances(3) \
				.set_life_spawn(10) \
				.set_spawn_locations([]) \
				.set_spawn_probability(0.6) \
				.build()
		) \
		.add_edible_rules(
			EdibleRulesBuiler.new() \
				.set_type(EdibleTypes.GAIN_COIN()) \
				.set_max_instances(3) \
				.set_life_spawn(3) \
				.set_spawn_locations([]) \
				.set_spawn_probability(0.2) \
				.build()
		) \
		.add_edible_rules(
			EdibleRulesBuiler.new() \
				.set_type(EdibleTypes.LOSS_COIN()) \
				.set_max_instances(3) \
				.set_life_spawn(3) \
				.set_spawn_locations([]) \
				.set_spawn_probability(0.4) \
				.build()
		)
	visual_parameters_builder \
		.add_edible_sprite(EdibleSprite.new(edibles_skin_path, EdibleTypes.APPLE())) \
		.add_edible_sprite(EdibleSprite.new(edibles_skin_path, EdibleTypes.CHERRY())) \
		.add_edible_sprite(EdibleSprite.new(edibles_skin_path, EdibleTypes.BAD_APPLE())) \
		.add_edible_sprite(EdibleSprite.new(edibles_skin_path, EdibleTypes.GAIN_COIN())) \
		.add_edible_sprite(EdibleSprite.new(edibles_skin_path, EdibleTypes.LOSS_COIN()))
	_set_px(visual_parameters_builder, width, heigh)

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
