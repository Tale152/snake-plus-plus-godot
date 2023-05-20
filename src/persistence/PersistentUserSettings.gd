extends Node

const _SETTINGS_FILE_PATH: String = "user://user_settings.json"
const _CONTROLS: String = "controls"
const _MASTER_BUS_VOLUME_PERCENTAGE = "master_volume_percentage"

func _ready():
	if not Persistence.exists(_SETTINGS_FILE_PATH):
		Persistence.write(_SETTINGS_FILE_PATH, _get_default_settings())
	else:
		var has_changed: bool = false
		var data: Dictionary = Persistence.read(_SETTINGS_FILE_PATH)
		var changes: int = 0
		changes += Persistence.fix_field(data, _CONTROLS, "Swipe")
		changes += Persistence.fix_field(data, _MASTER_BUS_VOLUME_PERCENTAGE, 1.0)
		if changes > 0:
			Persistence.write(_SETTINGS_FILE_PATH, data)

func get_controls() -> String:
	return Persistence.read(_SETTINGS_FILE_PATH)[_CONTROLS]

func set_controls(controls: String) -> void:
	var data: Dictionary = Persistence.read(_SETTINGS_FILE_PATH)
	data[_CONTROLS] = controls
	Persistence.write(_SETTINGS_FILE_PATH, data)

func get_master_bus_volume_percentage() -> float:
	return Persistence.read(_SETTINGS_FILE_PATH)[_MASTER_BUS_VOLUME_PERCENTAGE]

func set_master_bus_volume_percentage(percentage: float) -> void:
	var data: Dictionary = Persistence.read(_SETTINGS_FILE_PATH)
	data[_MASTER_BUS_VOLUME_PERCENTAGE] = percentage
	Persistence.write(_SETTINGS_FILE_PATH, data)

func _get_default_settings() -> Dictionary:
	return {
		_CONTROLS: "Swipe",
		_MASTER_BUS_VOLUME_PERCENTAGE: 1.0
	}
