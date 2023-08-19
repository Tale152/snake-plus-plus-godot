extends PersistentDictionaryNode

const _STAGES: String = "stages"
const _SCORE_RECORD_NOOB: String = "score_record_noob"
const _LENGTH_RECORD_NOOB: String = "length_record_noob"
const _SCORE_RECORD_REGULAR: String = "score_record_regular"
const _LENGTH_RECORD_REGULAR: String = "length_record_regular"
const _SCORE_RECORD_PRO: String = "score_record_pro"
const _LENGTH_RECORD_PRO: String = "length_record_pro"
const _UUID: String = "uuid"
const _ARCADE: String = "arcade"
const _STARS: String = "stars"
const _TIME: String = "time"
const _SCORE: String = "score"
const _LENGTH: String = "length"

const _FILE_PATH: String = "user://stages_data.json"
const _DEFAULT: Dictionary = {
	_STAGES: []
}

func _ready():
	_initialize(_DEFAULT, _FILE_PATH)

# key: uuid, value: StageData
func get_stages() -> Dictionary:
	var stored_stages: Array = _get_data(_STAGES)
	var result: Dictionary = {}
	for stage in stored_stages:
		result[stage[_UUID]] = _dictionary_to_stage_data(stage)
	return result

# key: uuid, value: StageData
func set_stages(stages: Dictionary) -> void:
	var to_be_stored: Array = []
	for uuid in stages.keys():
		to_be_stored.push_back(_stage_data_to_dictionary(
			uuid,
			stages[uuid]
		))
	_set_data(_STAGES, to_be_stored)

func set_new_challenge_stars(uuid: String, stars: int) -> void:
	var current_stages: Dictionary = get_stages()
	current_stages[uuid].set_stars(stars)
	set_stages(current_stages)

func set_new_arcade_record(uuid: String, arcade_record: ArcadeRecord) -> void:
	var current_stages: Dictionary = get_stages()
	current_stages[uuid].set_arcade_record(arcade_record)
	set_stages(current_stages)

func unlock_stage(uuid: String) -> bool:
	var current_stages: Dictionary = get_stages()
	if current_stages.has(uuid): return false
	current_stages[uuid] = StageData.new(0, ArcadeRecord.new(
		null, null, null, null, null, null
	))
	set_stages(current_stages)
	return true

func _stage_data_to_dictionary(
	uuid: String, stage_data: StageData
) -> Dictionary:
	var result: Dictionary = {}
	result[_UUID] = uuid #if done in "result" declaration id does not work
	result[_STARS] = stage_data.get_stars()
	var arcade_data: Dictionary = {}
	var arcade_record = stage_data.get_arcade_record()
	if arcade_record != null:
		_add_arcade_records_by_difficulty(
			arcade_data, arcade_record, PersistentPlaySettings.NOOB, _SCORE_RECORD_NOOB, _LENGTH_RECORD_NOOB
		)
		_add_arcade_records_by_difficulty(
			arcade_data, arcade_record, PersistentPlaySettings.REGULAR, _SCORE_RECORD_REGULAR, _LENGTH_RECORD_REGULAR
		)
		_add_arcade_records_by_difficulty(
			arcade_data, arcade_record, PersistentPlaySettings.PRO, _SCORE_RECORD_PRO, _LENGTH_RECORD_PRO
		)
	result[_ARCADE] = arcade_data
	return result

func _add_arcade_records_by_difficulty(
	result: Dictionary,
	arcade_record: ArcadeRecord,
	difficulty: String,
	score_key: String,
	length_key: String
):
	if arcade_record.get_score_record(difficulty) != null:
		result[score_key] = _stage_result_to_dictionary(
			arcade_record.get_score_record(difficulty)
	)
	if arcade_record.get_length_record(difficulty) != null:
		result[length_key] = _stage_result_to_dictionary(
			arcade_record.get_length_record(difficulty)
	)

func _stage_result_to_dictionary(stage_result: StageResult) -> Dictionary:
	var result: Dictionary = {}
	result[_TIME] = stage_result.get_time()
	result[_LENGTH] = stage_result.get_length()
	result[_SCORE] = stage_result.get_score()
	return result

func _dictionary_to_stage_data(dictionary: Dictionary) -> StageData:
	var stars: int = 0
	var score_record_noob: StageResult = null
	var length_record_noob: StageResult = null
	var score_record_regular: StageResult = null
	var length_record_regular: StageResult = null
	var score_record_pro: StageResult = null
	var length_record_pro: StageResult = null
	
	if dictionary.has(_ARCADE):
		var arcade_dictionary = dictionary[_ARCADE]
		score_record_noob = _extract_stage_result_from_dictionary(
			arcade_dictionary, _SCORE_RECORD_NOOB
		)
		length_record_noob = _extract_stage_result_from_dictionary(
			arcade_dictionary, _LENGTH_RECORD_NOOB
		)
		score_record_regular = _extract_stage_result_from_dictionary(
			arcade_dictionary, _SCORE_RECORD_REGULAR
		)
		length_record_regular = _extract_stage_result_from_dictionary(
			arcade_dictionary, _LENGTH_RECORD_REGULAR
		)
		score_record_pro = _extract_stage_result_from_dictionary(
			arcade_dictionary, _SCORE_RECORD_PRO
		)
		length_record_pro = _extract_stage_result_from_dictionary(
			arcade_dictionary, _LENGTH_RECORD_PRO
		)
	var arcade_record = ArcadeRecord.new(
			score_record_noob, 
			length_record_noob,
			score_record_regular,
			length_record_regular,
			score_record_pro,
			length_record_pro
		)
	if dictionary.has(_STARS):
		stars = dictionary[_STARS]
	return StageData.new(stars, arcade_record)

func _extract_stage_result_from_dictionary(
	dictionary: Dictionary, record_type: String
) -> StageResult:
	if !dictionary.has(record_type):
		return null
	else:
		var record_dictionary: Dictionary = dictionary[record_type]
		return StageResult.new(
			record_dictionary[_TIME],
			record_dictionary[_SCORE],
			record_dictionary[_LENGTH]
		)
