extends PersistentDictionaryNode

const _STAGES: String = "stages"
const _SCORE_RECORD: String = "score_record"
const _LENGTH_RECORD: String = "length_record"
const _UUID: String = "uuid"
const _TIME: String = "time"
const _SCORE: String = "score"
const _LENGTH: String = "length"

const _FILE_PATH: String = "user://arcade_records.json"
const _DEFAULT: Dictionary = {
	_STAGES: []
}

func _ready():
	_initialize(_DEFAULT, _FILE_PATH)

# key: uuid, value: ArcadeRecord
func get_records() -> Dictionary:
	var stored_records: Array = _get_data(_STAGES)
	var result: Dictionary = {}
	for record in stored_records:
		result[record[_UUID]] = _dictionary_to_arcade_record(record)
	return result

# key: uuid, value: ArcadeRecord
func set_records(stages: Dictionary) -> void:
	var to_be_stored: Array = []
	for uuid in stages.keys():
		to_be_stored.push_back(_arcade_record_to_dictionary(
			uuid,
			stages[uuid]
		))
	_set_data(_STAGES, to_be_stored)

func set_new_record(uuid: String, arcade_record: ArcadeRecord) -> void:
	var current_records: Dictionary = get_records()
	current_records[uuid] = arcade_record
	set_records(current_records)

func _arcade_record_to_dictionary(
	uuid: String, arcade_record: ArcadeRecord
) -> Dictionary:
	var result: Dictionary = {
		_UUID = uuid
	}
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
	return {
		_TIME = stage_result.get_time(),
		_LENGTH = stage_result.get_length(),
		_SCORE = stage_result.get_score()
	}

func _dictionary_to_arcade_record(dictionary: Dictionary) -> ArcadeRecord:
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
