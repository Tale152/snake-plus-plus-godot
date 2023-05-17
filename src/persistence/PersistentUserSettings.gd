extends Node

const _SETTINGS_FILE_PATH: String = "user://user_settings.json"
const _CONTROLS: String = "controls"

func _ready():
	if not Persistence.exists(_SETTINGS_FILE_PATH):
		Persistence.write(_SETTINGS_FILE_PATH, _get_default_settings())
	else:
		var has_changed: bool = false
		var data: Dictionary = Persistence.read(_SETTINGS_FILE_PATH)
		var controls = data[_CONTROLS]
		if controls == null:
			data[_CONTROLS] = "Swipe"
			has_changed = true
		if has_changed:
			Persistence.write(_SETTINGS_FILE_PATH, data)

func get_controls() -> String:
	return Persistence.read(_SETTINGS_FILE_PATH)[_CONTROLS]

func set_controls(controls: String) -> void:
	var data: Dictionary = Persistence.read(_SETTINGS_FILE_PATH)
	data[_CONTROLS] = controls
	Persistence.write(_SETTINGS_FILE_PATH, data)

func _get_default_settings() -> Dictionary:
	return {
		_CONTROLS: "Swipe"
	}
