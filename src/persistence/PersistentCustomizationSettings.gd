extends Node

const _CUSTOMIZATION_FILE_PATH: String = "user://customization_settings.json"
const _SNAKE: String = "snake"
const _FIELD: String = "field"
const _PERKS: String = "perks"

func _ready():
	if not Persistence.exists(_CUSTOMIZATION_FILE_PATH):
		Persistence.write(_CUSTOMIZATION_FILE_PATH, _get_default_customization())
	else:
		var has_changed: bool = false
		var data: Dictionary = Persistence.read(_CUSTOMIZATION_FILE_PATH)
		var changes: int = 0
		changes += Persistence.fix_field(data, _SNAKE, "Simple")
		changes += Persistence.fix_field(data, _FIELD, "Simple")
		changes += Persistence.fix_field(data, _PERKS, "Simple")
		if changes > 0:
			Persistence.write(_CUSTOMIZATION_FILE_PATH, data)

func _get_default_customization() -> Dictionary:
	return {
		_SNAKE: "Simple",
		_FIELD: "Simple",
		_PERKS: "Simple"
	}

func get_snake_skin() -> String:
	return Persistence.read(_CUSTOMIZATION_FILE_PATH)[_SNAKE]

func set_snake_skin(skin: String) -> void:
	_set_string_value(_SNAKE, skin)

func get_field_skin() -> String:
	return Persistence.read(_CUSTOMIZATION_FILE_PATH)[_FIELD]

func set_field_skin(skin: String) -> void:
	_set_string_value(_FIELD, skin)

func get_perks_skin() -> String:
	return Persistence.read(_CUSTOMIZATION_FILE_PATH)[_PERKS]

func set_perks_skin(skin: String) -> void:
	_set_string_value(_PERKS, skin)

func _set_string_value(field_name: String, value: String) -> void:
	var data: Dictionary = Persistence.read(_CUSTOMIZATION_FILE_PATH)
	data[field_name] = value
	Persistence.write(_CUSTOMIZATION_FILE_PATH, data)
