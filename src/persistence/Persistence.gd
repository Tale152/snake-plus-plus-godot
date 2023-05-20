class_name Persistence

static func exists(path: String) -> bool:
	var file: File = File.new()
	var res = file.file_exists(path)
	file.close()
	return res

static func read(path: String) -> Dictionary:
	var file: File = File.new()
	_open_file(file, path, File.READ)
	var json_file: Dictionary = parse_json(file.get_as_text())
	file.close()
	return json_file

static func write(path: String, data: Dictionary) -> void:
	var file: File = File.new()
	_open_file(file, path, File.WRITE)
	file.store_string(JSON.print(data))
	file.close()

static func _open_file(file: File, path: String, mode) -> void:
	var err = file.open(path, mode)
	if err != OK:
		print("Error opening " + path)

static func fix_field(data: Dictionary, field_name: String, value) -> int:
	if data.has(field_name): return 0
	else:
		data[field_name] = value
		return 1
