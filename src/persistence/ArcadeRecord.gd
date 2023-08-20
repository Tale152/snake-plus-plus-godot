class_name ArcadeRecord extends Reference

var _regular_score_record: StageResult
var _regular_length_record: StageResult
var _pro_score_record: StageResult
var _pro_length_record: StageResult

func _init(
	regular_score_record: StageResult,
	regular_length_record: StageResult,
	pro_score_record: StageResult,
	pro_length_record: StageResult
):
	_regular_score_record = regular_score_record
	_regular_length_record = regular_length_record
	_pro_score_record = pro_score_record
	_pro_length_record = pro_length_record

func get_score_record(difficulty: String) -> StageResult:
	if(difficulty == PersistentPlaySettings.REGULAR): return _regular_score_record
	else: return _pro_score_record

func get_length_record(difficulty: String) -> StageResult:
	if(difficulty == PersistentPlaySettings.REGULAR): return _regular_length_record
	else: return _pro_length_record
