class_name ArcadeStageData extends Reference

var _stage_path: String
var _uuid: String
var _record: ArcadeRecord
var _is_unlocked: bool

func _init(
	stage_path: String,
	uuid: String,
	record: ArcadeRecord,
	is_unlocked: bool
):
	_stage_path = stage_path
	_uuid = uuid
	_record = record
	_is_unlocked = is_unlocked

func get_stage_path() -> String:
	return _stage_path

func get_uuid() -> String:
	return _uuid

func get_record() -> ArcadeRecord:
	return _record

func is_unlocked() -> bool:
	return _is_unlocked
