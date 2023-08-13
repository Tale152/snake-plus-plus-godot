class_name MainMenuContent extends Control

const _PlayMenuScene = preload("res://src/menu/play_menu_scene/PlayMenuScene.tscn")
const _CustomizationMenuScene = preload("res://src/menu/customization_menu/CustomizationMenuScene.tscn")
const _WikiMenuScene = preload("res://src/menu/wiki_menu/WikiMenuScene.tscn")
onready var _GameTitleLabelFont = preload("res://src/menu/main_menu_scene/GameTitleLabelFont.tres")
onready var _MenuButtonFont = preload("res://src/menu/main_menu_scene/MenuButtonFont.tres")

const _GAME_TITLE_DEFAULT_FONT_SIZE = 40
const _MENU_BUTTON_DEFAULT_FONT_SIZE = 25

var _main_scene_instance
var _main_menu_scene

func initialize(main_scene_instance, main_menu_scene) -> void:
	$PlayButton.text = TranslationsManager.get_localized_string(
		TranslationsManager.PLAY
	)
	$CustomizationButton.text = TranslationsManager.get_localized_string(
		TranslationsManager.CUSTOMIZATION
	)
	$WikiButton.text = TranslationsManager.get_localized_string(
		TranslationsManager.WIKI
	)
	_main_scene_instance = main_scene_instance
	_main_menu_scene = main_menu_scene

func scale(scale: int) -> void:
	_GameTitleLabelFont.size = _GAME_TITLE_DEFAULT_FONT_SIZE * scale
	_MenuButtonFont.size = _MENU_BUTTON_DEFAULT_FONT_SIZE * scale

func _on_PlayButton_pressed():
	_main_scene_instance.play_button_click_sound()
	var play_menu_scene: PlayMenuScene = _PlayMenuScene.instance()
	play_menu_scene.initialize(_main_scene_instance, _main_menu_scene)
	
func _on_CustomizationButton_pressed():
	_main_scene_instance.play_button_click_sound()
	var customization_menu_scene: CustomizationMenuScene = _CustomizationMenuScene.instance()
	customization_menu_scene.initialize(_main_scene_instance, _main_menu_scene)

func _on_WikiButton_pressed():
	_main_scene_instance.play_button_click_sound()
	var wiki_menu_scene: WikiMenuScene = _WikiMenuScene.instance()
	wiki_menu_scene.initialize(_main_scene_instance, _main_menu_scene)
