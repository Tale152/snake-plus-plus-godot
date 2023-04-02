class_name BackgroundGenerator

const CELL_SPRITE_SPEED_SCALE = 0.3

static func create_background_cells(
	stage_description: StageDescription,
	visual_parameters: VisualParameters
) -> Array:
	var res = []
	for x in range(0, stage_description.get_field_size().get_width()):
		for y in range(0, stage_description.get_field_size().get_height()):
			res.push_back(BackgroundCell.new(
				ImmutablePoint.new(x, y),
				visual_parameters
			))
	return res
