class_name ArcadeStageData extends Reference

var _stage_path: String
# var _is_unlocked: boolean
# var _grade: int
# var _record_length: int
# var _record_score: int

func _init(
	stage_path: String
):
	_stage_path = stage_path

func get_stage_path() -> String:
	return _stage_path
