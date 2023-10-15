class_name StageData extends Reference

var _stars_regular: int
var _stars_pro: int
var _regular_length_record: StageResult
var _pro_length_record: StageResult
var _regular_score_record: StageResult
var _pro_score_record: StageResult

func _init(
	stars_regular: int,
	stars_pro: int,
	regular_length_record: StageResult,
	pro_length_record: StageResult,
	regular_score_record: StageResult,
	pro_score_record: StageResult
):
	_stars_regular = stars_regular
	_stars_pro = stars_pro
	_regular_length_record = regular_length_record
	_pro_length_record = pro_length_record
	_regular_score_record = regular_score_record
	_pro_score_record = pro_score_record

func get_stars_regular() -> int:
	return _stars_regular

func set_stars_regular(stars: int) -> void:
	_stars_regular = stars

func get_stars_pro() -> int:
	return _stars_pro

func set_stars_pro(stars: int) -> void:
	_stars_pro = stars

func get_regular_length_record() -> StageResult:
	return _regular_length_record

func set_regular_length_record(record: StageResult) -> void:
	_regular_length_record = record

func get_pro_length_record() -> StageResult:
	return _pro_length_record

func set_pro_length_record(record: StageResult) -> void:
	_pro_length_record = record

func get_regular_score_record() -> StageResult:
	return _regular_score_record

func set_regular_score_record(record: StageResult) -> void:
	_regular_score_record = record

func get_pro_score_record() -> StageResult:
	return _pro_score_record

func set_pro_score_record(record: StageResult) -> void:
	_pro_score_record = record
