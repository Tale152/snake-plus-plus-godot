class_name CustomizationMenuContent extends Control

const _SKINS_ARRAY: Array = ["simple", "debug", "kawaii"]
var _main_scene_instance

func _ready():
	$SnakeOptionChooser.fill(
		"Snake", 
		_SKINS_ARRAY,
		_get_skins_array_index(PersistentCustomizationSettings.get_snake_skin()),
		funcref(self, "_change_snake")
	)
	$FieldOptionChooser.fill(
		"Field", 
		_SKINS_ARRAY,
		_get_skins_array_index(PersistentCustomizationSettings.get_field_skin()),
		funcref(self, "_change_field")
	)
	$PerksOptionChooser.fill(
		"Perks", 
		_SKINS_ARRAY,
		_get_skins_array_index(PersistentCustomizationSettings.get_perks_skin()),
		funcref(self, "_change_perks")
	)

func initialize(main_scene_instance) -> void:
	_main_scene_instance = main_scene_instance

func _change_snake(skin: String) -> void:
	_main_scene_instance.play_button_click_sound()
	PersistentCustomizationSettings.set_snake_skin(skin)

func _change_field(skin: String) -> void:
	_main_scene_instance.play_button_click_sound()
	PersistentCustomizationSettings.set_field_skin(skin)

func _change_perks(skin: String) -> void:
	_main_scene_instance.play_button_click_sound()
	PersistentCustomizationSettings.set_perks_skin(skin)

func _get_skins_array_index(skin: String) -> int:
	var i = 0
	for s in _SKINS_ARRAY:
		if skin == s: return i
		i += 1
	return 0
