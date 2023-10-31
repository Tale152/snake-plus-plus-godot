extends PersistentDictionaryNode

const _SKIN: String = "skin"
const _UNLOCKED: String = "unlocked"
const _STARTING_SKIN: String = "0c0ee443-97c5-42b2-a334-f57daf4484f2"

const _FILE_PATH: String = "user://customization_settings.json"
const _DEFAULT: Dictionary = {
	_SKIN: _STARTING_SKIN,
	_UNLOCKED: [_STARTING_SKIN]
}

func _ready():
	_initialize(_DEFAULT, _FILE_PATH)

func get_selected_skin_uuid() -> String:
	return _get_data(_SKIN)

func set_selected_skin_uuid(uuid: String) -> void:
	_set_data(_SKIN, uuid)

func is_unlocked(uuid: String) -> bool:
	return ArrayUtils.get_array_index(_get_data(_UNLOCKED), uuid) > 0

func unlock(uuid: String) -> void:
	if !is_unlocked(uuid):
		var unlocked: Array = _get_data(_UNLOCKED)
		unlocked.push_back(uuid)
		_set_data(_UNLOCKED, unlocked)
 
