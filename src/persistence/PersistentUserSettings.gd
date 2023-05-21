extends Node

const _SETTINGS_FILE_PATH: String = "user://user_settings.json"
const _CONTROLS: String = "controls"
const _MUSIC_BUS_VOLUME = "music_volume"
const _EFFECTS_BUS_VOLUME = "effects_volume"

func _ready():
	if not Persistence.exists(_SETTINGS_FILE_PATH):
		Persistence.write(_SETTINGS_FILE_PATH, _get_default_settings())
	else:
		var data: Dictionary = Persistence.read(_SETTINGS_FILE_PATH)
		var changes: int = 0
		changes += Persistence.fix_field(data, _CONTROLS, "Swipe")
		changes += Persistence.fix_field(data, _MUSIC_BUS_VOLUME, 0)
		changes += Persistence.fix_field(data, _EFFECTS_BUS_VOLUME, 0)
		_set_bus(2, data[_MUSIC_BUS_VOLUME])
		_set_bus(1, data[_EFFECTS_BUS_VOLUME])
		if changes > 0:
			Persistence.write(_SETTINGS_FILE_PATH, data)

func get_controls() -> String:
	return Persistence.read(_SETTINGS_FILE_PATH)[_CONTROLS]

func set_controls(controls: String) -> void:
	var data: Dictionary = Persistence.read(_SETTINGS_FILE_PATH)
	data[_CONTROLS] = controls
	Persistence.write(_SETTINGS_FILE_PATH, data)

func get_music_bus_volume() -> int:
	return Persistence.read(_SETTINGS_FILE_PATH)[_MUSIC_BUS_VOLUME]

func set_music_bus_volume(value: int) -> void:
	var data: Dictionary = Persistence.read(_SETTINGS_FILE_PATH)
	data[_MUSIC_BUS_VOLUME] = value
	Persistence.write(_SETTINGS_FILE_PATH, data)
	_set_bus(2, value)

func get_effects_bus_volume() -> int:
	return Persistence.read(_SETTINGS_FILE_PATH)[_EFFECTS_BUS_VOLUME]

func set_effects_bus_volume(value: int) -> void:
	var data: Dictionary = Persistence.read(_SETTINGS_FILE_PATH)
	data[_EFFECTS_BUS_VOLUME] = value
	Persistence.write(_SETTINGS_FILE_PATH, data)
	_set_bus(1, value)

func _set_bus(index: int, value: int) -> void:
	if value == -45:
		AudioServer.set_bus_mute(index, true)
	else:
		AudioServer.set_bus_mute(index, false)
		AudioServer.set_bus_volume_db(index, value)

func _get_default_settings() -> Dictionary:
	return {
		_CONTROLS: "Swipe",
		_MUSIC_BUS_VOLUME: 0,
		_EFFECTS_BUS_VOLUME: 0
	}
