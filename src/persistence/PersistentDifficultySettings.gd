extends Node

const _DIFFICULTY_FILE_PATH: String = "user://difficulty_settings.json"
const _ARCADE: String = "arcade"

func _ready():
	if not Persistence.exists(_DIFFICULTY_FILE_PATH):
		Persistence.write(_DIFFICULTY_FILE_PATH, _get_default_difficulty())
	else:
		var has_changed: bool = false
		var data: Dictionary = Persistence.read(_DIFFICULTY_FILE_PATH)
		var arcade_difficulty = data[_ARCADE]
		if arcade_difficulty == null:
			data[_ARCADE] = "Regular"
			has_changed = true
		if has_changed:
			Persistence.write(_DIFFICULTY_FILE_PATH, data)

func get_arcade_difficulty() -> String:
	return Persistence.read(_DIFFICULTY_FILE_PATH)[_ARCADE]

func set_arcade_difficulty(difficulty: String) -> void:
	var data: Dictionary = Persistence.read(_DIFFICULTY_FILE_PATH)
	data[_ARCADE] = difficulty
	Persistence.write(_DIFFICULTY_FILE_PATH, data)

func _get_default_difficulty() -> Dictionary:
	return {
		_ARCADE: "Regular"
	}
