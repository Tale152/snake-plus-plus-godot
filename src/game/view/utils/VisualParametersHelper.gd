class_name VisualParametersHelper extends Reference

static func load_visual_parameters(
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
				str(selected_skin, "/perks"),
				p.get_type()
		))
	vpb \
		.set_snake_skin_path(str(selected_skin, "/snake")) \
		.set_field_elements_skin_path(str(selected_skin, "/field")) \
		.set_cell_pixels_size(px) \
		.set_game_pixels_offset(Vector2(offset, offset))
	return vpb.build()
