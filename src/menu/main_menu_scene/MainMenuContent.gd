class_name MainMenuContent extends Control

const _AdventureMenuScene = preload("res://src/menu/adventure_menu/AdventureMenuScene.tscn")
const _ArcadeMenuScene = preload("res://src/menu/arcade_menu_scene/ArcadeMenuScene.tscn")
const _CustomizationMenuScene = preload("res://src/menu/customization_menu/CustomizationMenuScene.tscn")
const _WikiMenuScene = preload("res://src/menu/wiki_menu/WikiMenuScene.tscn")
onready var _GameTitleLabelFont = preload("res://src/menu/main_menu_scene/GameTitleLabelFont.tres")
onready var _MenuButtonFont = preload("res://src/menu/main_menu_scene/MenuButtonFont.tres")

const _GAME_TITLE_DEFAULT_FONT_SIZE = 40
const _MENU_BUTTON_DEFAULT_FONT_SIZE = 25

var _main_scene_instance
var _main_menu_scene

func initialize(main_scene_instance, main_menu_scene) -> void:
	$AdventureButton.text = TranslationsManager.get_localized_string(
		TranslationsManager.ADVENTURE
	)
	_main_scene_instance = main_scene_instance
	_main_menu_scene = main_menu_scene

func scale(scale: int) -> void:
	_GameTitleLabelFont.size = _GAME_TITLE_DEFAULT_FONT_SIZE * scale
	_MenuButtonFont.size = _MENU_BUTTON_DEFAULT_FONT_SIZE * scale

func _on_AdventureButton_pressed():
	_main_scene_instance.play_button_click_sound()
	var adventure_menu_scene: AdventureMenuScene = _AdventureMenuScene.instance()
	adventure_menu_scene.initialize(_main_scene_instance, _main_menu_scene)

func _on_ArcadeButton_pressed():
	_main_scene_instance.play_button_click_sound()
	var arcade_menu_scene: ArcadeMenuScene = _ArcadeMenuScene.instance()
	arcade_menu_scene.initialize(_main_scene_instance, _main_menu_scene)

func _on_CustomizationButton_pressed():
	_main_scene_instance.play_button_click_sound()
	var customization_menu_scene: CustomizationMenuScene = _CustomizationMenuScene.instance()
	customization_menu_scene.initialize(_main_scene_instance, _main_menu_scene)

func _on_WikiButton_pressed():
	_main_scene_instance.play_button_click_sound()
	var wiki_menu_scene: WikiMenuScene = _WikiMenuScene.instance()
	wiki_menu_scene.initialize(_main_scene_instance, _main_menu_scene)
