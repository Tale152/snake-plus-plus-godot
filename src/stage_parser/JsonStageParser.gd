class_name JsonStageParser extends Reference

static func parse(path: String) -> ParsedStage:
	var json_data = _parse_json(path)
	if json_data == null || !(json_data is Dictionary): return null
	if !_is_value_valid(json_data, "version", TYPE_REAL): return null
	if !_is_value_valid(json_data, "stage", TYPE_DICTIONARY): return null
	
	var version: float = json_data.version
	var stage: Dictionary = json_data.stage
	if !JsonStageValidator.is_valid(version, stage): return null
	stage = JsonStageUpdater.update_to_latest_version(version, stage)
	return ParsedStage.new(stage)
	
static func _parse_json(path: String):
	var file = File.new()
	var open_file_result = file.open(path, File.READ)
	if open_file_result != 0:
		print("ERROR: cannot open file at path " + path)
		file.close()
		return null
	var json_data = parse_json(file.get_as_text())
	file.close()
	if json_data == null:
		print("ERROR: cannot parse to a valid json the content of " + path)
		return null
	return json_data

static func _is_value_valid(json_data: Dictionary, name: String, type: int):
	var res = DictionaryUtil.contains(json_data, name, type)
	if !res: print("ERROR: the parsed stage does not contain a valid " + name + " field")
	return res
