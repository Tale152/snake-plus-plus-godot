extends PersistentDictionaryNode

const _STAGES: String = "stages"
const _UUID: String = "uuid"
const _STARS_REGULAR: String = "stars_regular"
const _STARS_PRO: String = "stars_pro"
const _ARCADE_REGULAR_LENGTH: String = "arcade_regular_length"
const _ARCADE_PRO_LENGTH: String = "arcade_pro_length"
const _ARCADE_REGULAR_SCORE: String = "arcade_regular_score"
const _ARCADE_PRO_SCORE: String = "arcade_pro_score"
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

func set_new_challenge_stars_regular(uuid: String, stars: int) -> void:
	var current_stages: Dictionary = get_stages()
	current_stages[uuid].set_stars_regular(stars)
	set_stages(current_stages)

func set_new_challenge_stars_pro(uuid: String, stars: int) -> void:
	var current_stages: Dictionary = get_stages()
	current_stages[uuid].set_stars_pro(stars)
	set_stages(current_stages)

func set_new_arcade_regular_length_record(uuid: String, record: StageResult) -> void:
	var current_stages: Dictionary = get_stages()
	current_stages[uuid].set_regular_length_record(record)
	set_stages(current_stages)

func set_new_arcade_pro_length_record(uuid: String, record: StageResult) -> void:
	var current_stages: Dictionary = get_stages()
	current_stages[uuid].set_pro_length_record(record)
	set_stages(current_stages)

func set_new_arcade_regular_score_record(uuid: String, record: StageResult) -> void:
	var current_stages: Dictionary = get_stages()
	current_stages[uuid].set_regular_score_record(record)
	set_stages(current_stages)

func set_new_arcade_pro_score_record(uuid: String, record: StageResult) -> void:
	var current_stages: Dictionary = get_stages()
	current_stages[uuid].set_pro_score_record(record)
	set_stages(current_stages)

func unlock_stage(uuid: String) -> bool:
	var current_stages: Dictionary = get_stages()
	if current_stages.has(uuid): return false
	current_stages[uuid] = StageData.new(0, 0, null, null, null, null)
	set_stages(current_stages)
	return true

func _stage_data_to_dictionary(
	uuid: String, stage_data: StageData
) -> Dictionary:
	var result: Dictionary = {}
	result[_UUID] = uuid #if done in "result" declaration id does not work
	result[_STARS_REGULAR] = stage_data.get_stars_regular()
	result[_STARS_PRO] = stage_data.get_stars_pro()
	
	var regular_length_record = _stage_result_to_dictionary(stage_data.get_regular_length_record())
	if regular_length_record != null:
		result[_ARCADE_REGULAR_LENGTH] = regular_length_record
	var pro_length_record = _stage_result_to_dictionary(stage_data.get_pro_length_record())
	if pro_length_record != null:
		result[_ARCADE_PRO_LENGTH] = pro_length_record
	
	var regular_score_record = _stage_result_to_dictionary(stage_data.get_regular_score_record())
	if regular_score_record != null:
		result[_ARCADE_REGULAR_SCORE] = regular_score_record
	var pro_score_record = _stage_result_to_dictionary(stage_data.get_pro_score_record())
	if pro_score_record != null:
		result[_ARCADE_PRO_SCORE] = pro_score_record
	
	return result

func _stage_result_to_dictionary(record: StageResult):
	if record == null: return null
	var result: Dictionary = {}
	result[_LENGTH] = record.get_length()
	result[_SCORE] = record.get_score()
	result[_TIME] = record.get_time()
	return result

func _dictionary_to_stage_data(dictionary: Dictionary) -> StageData:
	var stars_regular: int = 0
	var stars_pro: int = 0
	var arcade_length_record_regular: StageResult = null
	var arcade_length_record_pro: StageResult = null
	var arcade_score_record_regular: StageResult = null
	var arcade_score_record_pro: StageResult = null
	
	if dictionary.has(_STARS_REGULAR):
		stars_regular = dictionary[_STARS_REGULAR]
	if dictionary.has(_STARS_PRO):
		stars_pro = dictionary[_STARS_PRO]
	
	if dictionary.has(_ARCADE_REGULAR_LENGTH):
		arcade_length_record_regular = _extract_stage_result_from_dictionary(
			dictionary[_ARCADE_REGULAR_LENGTH]
		)
	if dictionary.has(_ARCADE_PRO_LENGTH):
		arcade_length_record_pro = _extract_stage_result_from_dictionary(
			dictionary[_ARCADE_PRO_LENGTH]
		)
	
	if dictionary.has(_ARCADE_REGULAR_SCORE):
		arcade_score_record_regular = _extract_stage_result_from_dictionary(
			dictionary[_ARCADE_REGULAR_SCORE]
		)
	if dictionary.has(_ARCADE_PRO_SCORE):
		arcade_score_record_pro = _extract_stage_result_from_dictionary(
			dictionary[_ARCADE_PRO_SCORE]
		)
	
	return StageData.new(
		stars_regular,
		stars_pro,
		arcade_length_record_regular,
		arcade_length_record_pro,
		arcade_score_record_regular,
		arcade_score_record_pro
	)

func _extract_stage_result_from_dictionary(dictionary: Dictionary) -> StageResult:
	return StageResult.new(
		dictionary[_TIME],
		dictionary[_SCORE],
		dictionary[_LENGTH]
	)
