class_name JsonStageUpdater extends Reference

static func current_version() -> int: return 1

static func update_to_latest_version(
	stage_version: float,
	stage: Dictionary
) -> Dictionary:
	# when new versions arise this will be used to adapt the stage
	return stage
