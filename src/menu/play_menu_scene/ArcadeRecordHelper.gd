class_name ArcadeRecordHelper extends Reference

var _stages_data: Dictionary

func _init(stages_data: Dictionary):
	_stages_data = stages_data

func save_new_record(
	uuid: String, stage_result: StageResult
) -> void:
	var selected_stage_data: StageData = _stages_data[uuid]
	var refresh_data: bool = false
	
	if PersistentPlaySettings.get_difficulty() == PersistentPlaySettings.REGULAR:
		if _is_result_new_length_record(stage_result, selected_stage_data.get_regular_length_record()):
			PersistentStagesData.set_new_arcade_regular_length_record(uuid, stage_result)
			refresh_data = true
		if _is_result_new_score_record(stage_result, selected_stage_data.get_regular_score_record()):
			PersistentStagesData.set_new_arcade_regular_score_record(uuid, stage_result)
			refresh_data = true
	else:
		if _is_result_new_length_record(stage_result, selected_stage_data.get_pro_length_record()):
			PersistentStagesData.set_new_arcade_pro_length_record(uuid, stage_result)
			refresh_data = true
		if _is_result_new_score_record(stage_result, selected_stage_data.get_pro_score_record()):
			PersistentStagesData.set_new_arcade_pro_score_record(uuid, stage_result)
			refresh_data = true
	
	if refresh_data:
		_stages_data = PersistentStagesData.get_stages()

func _is_result_new_length_record(result: StageResult, current_record: StageResult) -> bool:
	if current_record == null: return true
	if result.get_length() > current_record.get_length(): return true
	if result.get_length() == current_record.get_length():
		if result.get_time() < current_record.get_time(): return true
		if result.get_time() == current_record.get_time():
			if result.get_score() > current_record.get_score(): return true
	return false

func _is_result_new_score_record(result: StageResult, current_record: StageResult) -> bool:
	if current_record == null: return true
	if result.get_score() > current_record.get_score(): return true
	if result.get_score() == current_record.get_score():
		if result.get_time() < current_record.get_time(): return true
		if result.get_time() == current_record.get_time():
			if result.get_length() > current_record.get_length(): return true
	return false
