class_name JsonStageValidator extends Reference

static func is_valid(version: float, stage: Dictionary) -> bool:
	if version == 1: return ValidatorV1.validate(stage)
	else:
		print(str(
			"ERROR: the stage version '",
			version,
			"' does not correspond to an existing parsable version"
		))
		return false
