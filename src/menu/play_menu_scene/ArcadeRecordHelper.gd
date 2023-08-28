class_name ArcadeRecordHelper extends Reference

var _stages_data: Dictionary

func _init(stages_data: Dictionary):
	_stages_data = stages_data

func save_new_record(
	uuid: String, stage_result: StageResult
) -> void:
	var selected_stage_data: StageData = _stages_data[uuid]
	if PersistentPlaySettings.get_difficulty() == PersistentPlaySettings.REGULAR:
		if _is_result_new_record(stage_result, selected_stage_data.get_regular_record()):
			PersistentStagesData.set_new_arcade_regular_record(uuid, stage_result)
			_stages_data = PersistentStagesData.get_stages()
	else:
		if _is_result_new_record(stage_result, selected_stage_data.get_pro_record()):
			PersistentStagesData.set_new_arcade_pro_record(uuid, stage_result)
			_stages_data = PersistentStagesData.get_stages()

func _is_result_new_record(result: StageResult, current_record: StageResult) -> bool:
	if current_record == null: return true
	if result.get_length() > current_record.get_length(): return true
	if result.get_length() == current_record.get_length():
		if result.get_score() > current_record.get_score(): return true
		if result.get_score() == current_record.get_score():
			if result.get_time() < current_record.get_time(): return true
	return false
