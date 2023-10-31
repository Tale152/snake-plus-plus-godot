class_name FileUtils extends Reference

static func get_directories_list(dir_path: String, sorter = null) -> Array:
	var directories = []
	var dir = Directory.new()
	dir.open(dir_path)
	dir.list_dir_begin()

	while true:
		var file = dir.get_next()
		if file == "":
			break
		elif not file.begins_with("."):
			directories.append(dir_path + "/" + file)

	dir.list_dir_end()
	if sorter != null:
		directories.sort_custom(sorter, "sort")
	return directories

static func get_json_file_content(file_path: String) -> Dictionary:
	var file = File.new()
	file.open(file_path, File.READ)
	var json_data = parse_json(file.get_as_text())
	file.close()
	return json_data

static func file_exists(file_path: String) -> bool:
	var file = File.new()
	var res: bool = file.file_exists(file_path)
	file.close()
	return res
