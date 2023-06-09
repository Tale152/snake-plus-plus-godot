extends PersistentDictionaryNode

const _ARCADE: String = "arcade"

const _FILE_PATH: String = "user://difficulty_settings.json"
const _DEFAULT: Dictionary = {
	_ARCADE: "Regular"
}

func _ready():
	_initialize(_DEFAULT, _FILE_PATH)

func get_arcade_difficulty() -> String:
	return _get_data(_ARCADE)

func set_arcade_difficulty(difficulty: String) -> void:
	_set_data(_ARCADE, difficulty)
