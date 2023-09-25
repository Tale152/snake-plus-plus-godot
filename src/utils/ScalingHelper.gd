class_name ScalingHelper extends Reference

static func get_int_size(default_value: int, scale: float) -> int:
	return int(floor(default_value * scale))

static func scale_label_text(
	label: Label, default_font_size: int, scale: float
) -> void:
	label.get_font("font", "Label").size = get_int_size(
		default_font_size, scale
	)

static func scale_label_outline(
	label: Label, default_outline_size: int, scale: float
) -> void:
	label.get_font("font", "Label").outline_size = get_int_size(
		default_outline_size, scale
	)
