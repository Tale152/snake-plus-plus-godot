extends PersistentDictionaryNode

const _STAGES: String = "stages"
const _SCORE_RECORD: String = "score_record"
const _LENGTH_RECORD: String = "length_record"
const _UUID: String = "uuid"
const _TIME: String = "time"
const _SCORE: String = "score"
const _LENGTH: String = "length"

const _FILE_PATH: String = "user://arcade_data.json"
const _DEFAULT: Dictionary = {
	_STAGES: []
}

func _ready():
	_initialize(_DEFAULT, _FILE_PATH)

# key: uuid, value: ArcadeRecord
func get_stages() -> Dictionary:
	var stored_stages: Array = _get_data(_STAGES)
	var result: Dictionary = {}
	for stage in stored_stages:
		result[stage[_UUID]] = _dictionary_to_arcade_stage(stage)
	return result

# key: uuid, value: ArcadeRecord
func set_stages(stages: Dictionary) -> void:
	var to_be_stored: Array = []
	for uuid in stages.keys():
		to_be_stored.push_back(_arcade_data_to_dictionary(
			uuid,
			stages[uuid]
		))
	_set_data(_STAGES, to_be_stored)

func set_new_record(uuid: String, arcade_record: ArcadeRecord) -> void:
	var current_records: Dictionary = get_stages()
	current_records[uuid] = arcade_record
	set_stages(current_records)

func unlock_stage(uuid: String) -> bool:
	var current_stages: Dictionary = get_stages()
	if current_stages.has(uuid): return false
	current_stages[uuid] = ArcadeRecord.new(null, null)
	set_stages(current_stages)
	return true

func _arcade_data_to_dictionary(
	uuid: String, arcade_record: ArcadeRecord
) -> Dictionary:
	var result: Dictionary = {}
	result[_UUID] = uuid #if done in "result" declaration id does not work
	if arcade_record.get_score_record() != null:
		result[_SCORE_RECORD] = _stage_result_to_dictionary(
			arcade_record.get_score_record()
	)
	if arcade_record.get_length_record() != null:
		result[_LENGTH_RECORD] = _stage_result_to_dictionary(
			arcade_record.get_length_record()
	)
	return result

func _stage_result_to_dictionary(stage_result: StageResult) -> Dictionary:
	var result: Dictionary = {}
	result[_TIME] = stage_result.get_time()
	result[_LENGTH] = stage_result.get_length()
	result[_SCORE] = stage_result.get_score()
	return result

func _dictionary_to_arcade_stage(dictionary: Dictionary) -> ArcadeRecord:
	var score_record: StageResult = _extract_stage_result_from_dictionary(
		dictionary, _SCORE_RECORD
	)
	var length_record: StageResult = _extract_stage_result_from_dictionary(
		dictionary, _LENGTH_RECORD
	)
	return ArcadeRecord.new(score_record, length_record)

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
