class_name ArcadeRecord extends Reference

var _score_record: StageResult
var _length_record: StageResult

func _init(score_record: StageResult, length_record: StageResult):
	_score_record = score_record
	_length_record = length_record

func get_score_record() -> StageResult:
	return _score_record

func get_length_record() -> StageResult:
	return _length_record
