class_name ArcadeRecord extends Reference

var _noob_score_record: StageResult
var _noob_length_record: StageResult
var _regular_score_record: StageResult
var _regular_length_record: StageResult
var _pro_score_record: StageResult
var _pro_length_record: StageResult

func _init(
	noob_score_record: StageResult,
	noob_length_record: StageResult,
	regular_score_record: StageResult,
	regular_length_record: StageResult,
	pro_score_record: StageResult,
	pro_length_record: StageResult
):
	_noob_score_record = noob_score_record
	_noob_length_record = noob_length_record
	_regular_score_record = regular_score_record
	_regular_length_record = regular_length_record
	_pro_score_record = pro_score_record
	_pro_length_record = pro_length_record

func get_score_record(difficulty: String) -> StageResult:
	if(difficulty == PersistentDifficultySettings.NOOB): return _noob_score_record
	elif(difficulty == PersistentDifficultySettings.REGULAR): return _regular_score_record
	else: return _pro_score_record

func get_length_record(difficulty: String) -> StageResult:
	if(difficulty == PersistentDifficultySettings.NOOB): return _noob_length_record
	elif(difficulty == PersistentDifficultySettings.REGULAR): return _regular_length_record
	else: return _pro_length_record
