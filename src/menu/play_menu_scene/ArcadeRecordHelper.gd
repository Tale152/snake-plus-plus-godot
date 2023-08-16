class_name ArcadeRecordHelper extends Reference

var _stages_data: Dictionary

func _init(stages_data: Dictionary):
	_stages_data = stages_data

func save_new_record(
	uuid: String, stage_result: StageResult
) -> void:
	var difficulty: String = PersistentPlaySettings.get_difficulty()
	var current_record: ArcadeRecord = _stages_data[uuid].get_arcade_record()
	if current_record == null:
		var new_record: ArcadeRecord
		if difficulty == PersistentPlaySettings.NOOB:
			new_record = ArcadeRecord.new(stage_result, stage_result, null, null, null, null)
		elif difficulty == PersistentPlaySettings.REGULAR:
			new_record = ArcadeRecord.new(null, null, stage_result, stage_result, null, null)
		else:
			new_record = ArcadeRecord.new(null, null, null, null, stage_result, stage_result)
		PersistentStagesData.set_new_arcade_record(
			uuid,
			new_record
		)
		_stages_data = PersistentStagesData.get_stages()
		return
	var current_length_record: StageResult = current_record.get_length_record(difficulty)
	var current_score_record: StageResult = current_record.get_score_record(difficulty)
	
	var new_length_record = null
	if current_length_record == null:
		new_length_record = stage_result
	elif stage_result.get_length() > current_length_record.get_length():
		new_length_record = stage_result
	elif stage_result.get_length() == current_length_record.get_length():
		if stage_result.get_score() > current_length_record.get_score():
			new_length_record = stage_result
		elif stage_result.get_score() == current_length_record.get_score():
			if stage_result.get_time() < current_length_record.get_time():
				new_length_record = stage_result
	
	var new_score_record = null
	if current_score_record == null:
		new_score_record = stage_result
	elif stage_result.get_score() > current_score_record.get_score():
		new_score_record = stage_result
	elif stage_result.get_score() == current_score_record.get_score():
		if stage_result.get_length() > current_score_record.get_length():
			new_score_record = stage_result
		elif stage_result.get_length() == current_score_record.get_length():
			if stage_result.get_time() < current_score_record.get_time():
				new_score_record = stage_result
	
	if new_length_record != null || new_score_record != null:
		if new_length_record != null:
			current_length_record = new_length_record
		if new_score_record != null:
			current_score_record = new_score_record
		var new_record: ArcadeRecord
		if difficulty == PersistentPlaySettings.NOOB:
			new_record = ArcadeRecord.new(
				current_score_record,
				current_length_record,
				current_record.get_score_record(PersistentPlaySettings.REGULAR),
				current_record.get_length_record(PersistentPlaySettings.REGULAR),
				current_record.get_score_record(PersistentPlaySettings.PRO),
				current_record.get_length_record(PersistentPlaySettings.PRO)
			)
		elif difficulty == PersistentPlaySettings.REGULAR:
			new_record = ArcadeRecord.new(
				current_record.get_score_record(PersistentPlaySettings.NOOB),
				current_record.get_length_record(PersistentPlaySettings.NOOB),
				current_score_record,
				current_length_record,
				current_record.get_score_record(PersistentPlaySettings.PRO),
				current_record.get_length_record(PersistentPlaySettings.PRO)
			)
		else:
			new_record = ArcadeRecord.new(
				current_record.get_score_record(PersistentPlaySettings.NOOB),
				current_record.get_length_record(PersistentPlaySettings.NOOB),
				current_record.get_score_record(PersistentPlaySettings.REGULAR),
				current_record.get_length_record(PersistentPlaySettings.REGULAR),
				current_score_record,
				current_length_record
			)
		PersistentStagesData.set_new_arcade_record(uuid, new_record)
		_stages_data = PersistentStagesData.get_stages()
