class_name StagesHelper extends Reference

const STAGES_PATH: String = "res://assets/stages/built_in"
const _INITIAL_STAGES_UNLOCKED_NUMBER: int = 3
const _STAGES_UNLOCK_PROGRESSION: int = 2

func list_stage_files() -> Array:
	var files = []
	var dir = Directory.new()
	dir.open(STAGES_PATH)
	dir.list_dir_begin()

	while true:
		var file = dir.get_next()
		if file == "":
			break
		elif not file.begins_with("."):
			files.append(file)

	dir.list_dir_end()
	files.sort_custom(self, "_sort_by_progressive")
	return files

func _sort_by_progressive(x_filename: String, y_filename: String) -> bool:
	var x_progr: int = int(x_filename.get_slice("-", 0).strip_edges(true, true))
	var y_progr: int = int(y_filename.get_slice("-", 0).strip_edges(true, true))
	return x_progr < y_progr

func unlock_initial_stages() -> void:
	var files: Array = list_stage_files()
	var currently_unlocked_stages: Dictionary = PersistentStagesData.get_stages()
	var i = 0
	for f in files:
		if i < _INITIAL_STAGES_UNLOCKED_NUMBER:
			var filepath: String = STAGES_PATH + "/" + f
			var file = File.new()
			file.open(filepath, File.READ)
			var json_data = parse_json(file.get_as_text())
			file.close()
			var uuid: String = json_data["uuid"]
			if !currently_unlocked_stages.has(uuid):
				PersistentStagesData.unlock_stage(uuid)
		else:
			return
		i += 1

func _do_stages_need_to_be_unlocked() -> bool:
	var currently_unlocked_stages: Dictionary = PersistentStagesData.get_stages()
	var unlocked_stages_number: int = 0
	var completed_stages: int = 0
	for uuid in currently_unlocked_stages.keys():
		unlocked_stages_number += 1
		var stage_data: StageData = currently_unlocked_stages[uuid]
		if stage_data.get_stars_regular() > 0:
			completed_stages += 1
	return (_INITIAL_STAGES_UNLOCKED_NUMBER - _STAGES_UNLOCK_PROGRESSION) == (unlocked_stages_number - completed_stages)

func unlock_stages() -> int:
	if !_do_stages_need_to_be_unlocked():
		return 0
	var currently_unlocked_stages: Dictionary = PersistentStagesData.get_stages()
	var files: Array = list_stage_files()
	if currently_unlocked_stages.keys().size() == files.size():
		return 0
	var stages_unlocked: int = 0
	for f in files:
		var filepath: String = STAGES_PATH + "/" + f
		var file = File.new()
		file.open(filepath, File.READ)
		var json_data = parse_json(file.get_as_text())
		file.close()
		var uuid: String = json_data["uuid"]
		if !currently_unlocked_stages.has(uuid):
			stages_unlocked += 1
			PersistentStagesData.unlock_stage(uuid)
			if stages_unlocked == _STAGES_UNLOCK_PROGRESSION:
				return stages_unlocked
	return stages_unlocked
