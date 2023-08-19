class_name MenuStageData extends Reference

var _stage_path: String
var _uuid: String

func _init(
	stage_path: String,
	uuid: String
):
	_stage_path = stage_path
	_uuid = uuid

func get_stage_path() -> String:
	return _stage_path

func get_uuid() -> String:
	return _uuid
