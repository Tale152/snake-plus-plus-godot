class_name SettingsMenuContent extends Control

const _CONTROLS_ARRAY: Array = ["Swipe", "Arrow", "Split"]

func _ready():
	$ControlsOptionChooser.fill(
		"Controls", 
		_CONTROLS_ARRAY,
		_get_controls_array_index(PersistentUserSettings.get_controls()),
		funcref(self, "_change_controls")
	)
	$MusicHSlider.value = PersistentUserSettings.get_master_bus_volume()

func scale(scale: float) -> void:
	$ControlsOptionChooser.scale_font(scale)

func _change_controls(controls: String) -> void:
	PersistentUserSettings.set_controls(controls)

func _get_controls_array_index(controls: String) -> int:
	var i = 0
	for c in _CONTROLS_ARRAY:
		if controls == c: return i
		i += 1
	return 0

func _on_MusicHSlider_value_changed(value: int) -> void:
	if value == -45:
		AudioServer.set_bus_mute(0, true)
	else:
		AudioServer.set_bus_mute(0, false)
		AudioServer.set_bus_volume_db(0, value)
	PersistentUserSettings.set_master_bus_volume(value)
