extends Control

var SNAKE_SPAWN_POINT = ImmutablePoint.new(0,0)
var SNAKE_INITIAL_DIRECTION = Directions.get_right()

var _main

func _ready():
	$SpeedContainer/SpeedItemList.select(2)
	$SkinContainer/SkinItemList.select(1)

func set_main(main) -> void:
	_main = main

func _on_PlayButton_pressed():
	var description_builder = StageDescriptionBuilder.new()
	match $SpeedContainer/SpeedItemList.get_selected_items()[0]:
		0: description_builder.set_snake_speedup_factor(0.995).set_snake_base_delta_seconds(0.5)
		1: description_builder.set_snake_speedup_factor(0.99).set_snake_base_delta_seconds(0.45)
		2: description_builder.set_snake_speedup_factor(0.985).set_snake_base_delta_seconds(0.4)
		3: description_builder.set_snake_speedup_factor(0.98).set_snake_base_delta_seconds(0.3)
		4: description_builder.set_snake_speedup_factor(0.975).set_snake_base_delta_seconds(0.2)
	description_builder \
		.set_field_size(FieldSize.new(int($FieldContainer/WidthTextEdit.text), int($FieldContainer/HeightTextEdit.text))) \
		.set_snake_spawn_point(SNAKE_SPAWN_POINT) \
		.set_snake_initial_direction(Directions.get_right())
	if $AppleContainer/AppleCheckBox.pressed:
		var apple_rules = EdibleRulesBuiler.new() \
			.set_max_instances(int($AppleContainer/AppleNumberTextEdit.text)) \
			.set_spawn_locations([]) \
			.set_life_spawn(-1) \
			.set_spawn_probability(float($AppleContainer/AppleProbabilityTextEdit.text)) \
			.set_type(EdibleTypes.APPLE()) \
			.build()
		description_builder.add_edible_rules(apple_rules)
	if $BadAppleContainer/BadAppleCheckBox.pressed:
		var bad_apple_rules = EdibleRulesBuiler.new() \
			.set_max_instances(int($BadAppleContainer/BadAppleNumberTextEdit.text)) \
			.set_spawn_locations([]) \
			.set_life_spawn(-1) \
			.set_spawn_probability(float($BadAppleContainer/BadAppleProbabilityTextEdit.text)) \
			.set_type(EdibleTypes.BAD_APPLE()) \
			.build()
		description_builder.add_edible_rules(bad_apple_rules)
	var description: StageDescription = description_builder.build()
	if description != null:
		var width_px = OS.window_size.x / int($FieldContainer/WidthTextEdit.text)
		var heigh_px = OS.window_size.y / int($FieldContainer/HeightTextEdit.text)
		var cell_px_size = width_px if width_px < heigh_px else heigh_px
		var selected_skin = str(
			"res://assets/skins/", $SkinContainer/SkinItemList.get_item_text($SkinContainer/SkinItemList.get_selected_items()[0])
		)
		var visual_parameters_builder = VisualParametersBuilder.new() \
			.set_cell_pixels_size(cell_px_size) \
			.set_game_pixels_offset(Vector2(
				(OS.window_size.x - int($FieldContainer/WidthTextEdit.text) * cell_px_size) / 2,
				(OS.window_size.y - int($FieldContainer/HeightTextEdit.text) * cell_px_size) / 2
			)) \
			.set_snake_skin_path(str(selected_skin, "/snake")) \
			.set_field_elements_skin_path(str(selected_skin, "/field"))
		if $AppleContainer/AppleCheckBox.pressed:
			visual_parameters_builder.add_edible_sprite(EdibleSprite.new(str(selected_skin, "/edibles"), "Apple"))
		if $BadAppleContainer/BadAppleCheckBox.pressed:
			visual_parameters_builder.add_edible_sprite(EdibleSprite.new(str(selected_skin, "/edibles"), "BadApple"))
		_main.play(description, visual_parameters_builder.build())
	else:
		$WrongInputAcceptDialog.popup()
