extends PersistentDictionaryNode

const _MODE: String = "mode"
const _DIFFICULTY: String = "difficulty"

const CHALLENGE: String = "Challenge"
const ARCADE: String = "Arcade"

const NOOB: String = "Noob"
const REGULAR: String = "Regular"
const PRO: String = "Pro"

const _FILE_PATH: String = "user://play_settings.json"
const _DEFAULT: Dictionary = {
	_MODE: CHALLENGE,
	_DIFFICULTY: REGULAR
}

func _ready():
	_initialize(_DEFAULT, _FILE_PATH)

func get_mode() -> String:
	return _get_data(_MODE)

func set_mode(mode: String) -> void:
	_set_data(_MODE, mode)

func get_difficulty() -> String:
	return _get_data(_DIFFICULTY)

func set_difficulty(difficulty: String) -> void:
	_set_data(_DIFFICULTY, difficulty)
