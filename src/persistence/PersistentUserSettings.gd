extends PersistentDictionaryNode

const _LANGUAGE: String = "language"
const _CONTROLS: String = "controls"
const _MUSIC_BUS_VOLUME = "music_volume"
const _EFFECTS_BUS_VOLUME = "effects_volume"

const _FILE_PATH: String = "user://user_settings.json"
func _get_default() -> Dictionary:
	var lang: String = ""
	for supported_lang in TranslationsManager.get_supported_languages().values():
		if supported_lang == TranslationsManager.get_os_language():
			lang = supported_lang
	if lang == "": lang = TranslationsManager.FALLBACK_LANGUAGE_ID
	return {
		_LANGUAGE: lang,
		_CONTROLS: "Swipe",
		_MUSIC_BUS_VOLUME: 0,
		_EFFECTS_BUS_VOLUME: 0
	}

func _ready():
	_initialize(_get_default(), _FILE_PATH)

func get_language() -> String:
	return _get_data(_LANGUAGE)

func set_language(language: String) -> void:
	TranslationServer.set_locale(language)
	_set_data(_LANGUAGE, language)

func get_controls() -> String:
	return _get_data(_CONTROLS)

func set_controls(controls: String) -> void:
	_set_data(_CONTROLS, controls)

func get_music_bus_volume() -> int:
	return _get_data(_MUSIC_BUS_VOLUME)

func set_music_bus_volume(value: int) -> void:
	_set_data(_MUSIC_BUS_VOLUME, value)
	_set_bus(2, value)

func get_effects_bus_volume() -> int:
	return _get_data(_EFFECTS_BUS_VOLUME)

func set_effects_bus_volume(value: int) -> void:
	_set_data(_EFFECTS_BUS_VOLUME, value)
	_set_bus(1, value)

func _set_bus(index: int, value: int) -> void:
	if value == -45:
		AudioServer.set_bus_mute(index, true)
	else:
		AudioServer.set_bus_mute(index, false)
		AudioServer.set_bus_volume_db(index, value)
