class_name SettingsMenuContent extends Control

const _CONTROLS_ARRAY: Array = ["Swipe", "Arrow", "Split"]
var _main_scene_instance

func _ready():
	$ControlsOptionChooser.fill(
		"Controls", 
		_CONTROLS_ARRAY,
		_get_controls_array_index(PersistentUserSettings.get_controls()),
		funcref(self, "_change_controls")
	)
	$MusicHSlider.value = PersistentUserSettings.get_music_bus_volume()
	$EffectsHSlider.value = PersistentUserSettings.get_effects_bus_volume()

func scale(scale: float) -> void:
	$ControlsOptionChooser.scale_font(scale)

func initialize(main_scene_instance) -> void:
	_main_scene_instance  = main_scene_instance

func _change_controls(controls: String) -> void:
	_main_scene_instance.play_button_click_sound()
	PersistentUserSettings.set_controls(controls)

func _get_controls_array_index(controls: String) -> int:
	var i = 0
	for c in _CONTROLS_ARRAY:
		if controls == c: return i
		i += 1
	return 0

func _on_MusicHSlider_value_changed(value: int) -> void:
	PersistentUserSettings.set_music_bus_volume(value)

func _on_EffectsHSlider_value_changed(value):
	PersistentUserSettings.set_effects_bus_volume(value)
