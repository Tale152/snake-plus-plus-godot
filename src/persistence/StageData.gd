class_name StageData extends Reference

var _stars_regular: int
var _stars_pro: int
var _regular_record: StageResult
var _pro_record: StageResult

func _init(
	stars_regular: int,
	stars_pro: int,
	regular_record: StageResult,
	pro_record: StageResult
):
	_stars_regular = stars_regular
	_stars_pro = stars_pro
	_regular_record = regular_record
	_pro_record = pro_record

func get_stars_regular() -> int:
	return _stars_regular

func set_stars_regular(stars: int) -> void:
	_stars_regular = stars

func get_stars_pro() -> int:
	return _stars_pro

func set_stars_pro(stars: int) -> void:
	_stars_pro = stars

func get_regular_record() -> StageResult:
	return _regular_record

func set_regular_record(record: StageResult) -> void:
	_regular_record = record

func get_pro_record() -> StageResult:
	return _pro_record

func set_pro_record(record: StageResult) -> void:
	_pro_record = record
