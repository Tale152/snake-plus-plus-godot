class_name SettingsMenuContent extends Control

const _CONTROLS_ARRAY: Array = ["Swipe", "Arrow", "Split"]

func _ready():
	$ControlsOptionChooser.fill(
		"Controls", 
		_CONTROLS_ARRAY,
		_get_controls_array_index(UserSettings.get_controls()),
		funcref(self, "_change_controls")
	)

func scale(scale: float) -> void:
	$ControlsOptionChooser.scale_font(scale)

func _change_controls(controls: String) -> void:
	UserSettings.set_controls(controls)

func _get_controls_array_index(controls: String) -> int:
	var i = 0
	for c in _CONTROLS_ARRAY:
		if controls == c: return i
		i += 1
	return 0
