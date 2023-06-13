class_name ArcadeStageData extends Reference

var _stage_path: String
var _uuid: String
var _record: ArcadeRecord
# var _is_unlocked: boolean
# var _grade: int
# var _record_length: int
# var _record_score: int

func _init(
	stage_path: String,
	uuid: String,
	record: ArcadeRecord
):
	_stage_path = stage_path
	_uuid = uuid
	_record = record

func get_stage_path() -> String:
	return _stage_path
