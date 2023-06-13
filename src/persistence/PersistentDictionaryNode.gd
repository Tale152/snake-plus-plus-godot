class_name PersistentDictionaryNode extends Node

var _current_data: Dictionary
var _file_path: String

func _initialize(
	default_values: Dictionary,
	file_path: String
):
	_file_path = file_path
	if not _exists(file_path):
		_current_data = default_values
		_write_on_file()
	else:
		var changes: int = 0
		var keys = Array(default_values.keys())
		_current_data = _read(_file_path)
		for key in keys:
			changes += _fix_field(_current_data, key, default_values[key])
		if changes > 0: _write_on_file()

func _get_data(key: String):
	return _current_data[key]

func _set_data(key: String, value) -> void:
	_current_data[key] = value
	_write_on_file()

func _write_on_file() -> void:
	_write(_file_path, _current_data)

func _exists(path: String) -> bool:
	var file: File = File.new()
	var res = file.file_exists(path)
	file.close()
	return res

func _read(path: String) -> Dictionary:
	var file: File = File.new()
	_open_file(file, path, File.READ)
	var json_file: Dictionary = parse_json(file.get_as_text())
	file.close()
	return json_file

func _write(path: String, data: Dictionary) -> void:
	var file: File = File.new()
	_open_file(file, path, File.WRITE)
	file.store_string(JSON.print(data, "\t"))
	file.close()

func _open_file(file: File, path: String, mode) -> void:
	var err = file.open(path, mode)
	if err != OK:
		print("Error opening " + path)

func _fix_field(data: Dictionary, field_name: String, value) -> int:
	if data.has(field_name): return 0
	else:
		data[field_name] = value
		return 1
