extends Control

var _main

func _ready():
	$SpeedContainer/SpeedItemList.select(2)
	$SkinContainer/SkinItemList.select(0)
	$StageContainer/StageItemList.select(0)

func set_main(main) -> void:
	_main = main

func _on_PlayButton_pressed():
	var description_builder = StageDescriptionBuilder.new()
	match $SpeedContainer/SpeedItemList.get_selected_items()[0]:
		0: description_builder.set_snake_speedup_factor(0.995).set_snake_base_delta_seconds(0.6)
		1: description_builder.set_snake_speedup_factor(0.994).set_snake_base_delta_seconds(0.55)
		2: description_builder.set_snake_speedup_factor(0.993).set_snake_base_delta_seconds(0.5)
		3: description_builder.set_snake_speedup_factor(0.992).set_snake_base_delta_seconds(0.45)
		4: description_builder.set_snake_speedup_factor(0.991).set_snake_base_delta_seconds(0.4)
	var selected_skin = str(
		"res://assets/skins/", $SkinContainer/SkinItemList.get_item_text($SkinContainer/SkinItemList.get_selected_items()[0])
	)
	var visual_parameters_builder = VisualParametersBuilder.new()
	visual_parameters_builder \
		.set_snake_skin_path(str(selected_skin, "/snake")) \
		.set_field_elements_skin_path(str(selected_skin, "/field"))
	var selected_stage: int
	match $StageContainer/StageItemList.get_selected_items()[0]:
		0: selected_stage = 0
		1: selected_stage = 1
		2: selected_stage = 2
	
	DevMenuStages.complete_builders(
		description_builder,
		visual_parameters_builder,
		str(selected_skin, "/edibles"),
		selected_stage
	)
	_main.play(description_builder.build(), visual_parameters_builder.build())
