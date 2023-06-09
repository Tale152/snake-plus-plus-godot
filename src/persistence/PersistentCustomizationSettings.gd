extends PersistentDictionaryNode

const _SNAKE: String = "snake"
const _FIELD: String = "field"
const _PERKS: String = "perks"

const _FILE_PATH: String = "user://customization_settings.json"
const _DEFAULT: Dictionary = {
	_SNAKE: "simple",
	_FIELD: "simple",
	_PERKS: "simple"
}

func _ready():
	_initialize(_DEFAULT, _FILE_PATH)

func get_snake_skin() -> String:
	return _get_data(_SNAKE)

func set_snake_skin(skin: String) -> void:
	_set_data(_SNAKE, skin)

func get_field_skin() -> String:
	return _get_data(_FIELD)

func set_field_skin(skin: String) -> void:
	_set_data(_FIELD, skin)

func get_perks_skin() -> String: 
	return _get_data(_PERKS)

func set_perks_skin(skin: String) -> void:
	_set_data(_PERKS, skin)
