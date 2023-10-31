class_name CustomizationMenuContent extends Control

const SKINS_PATH: String = "res://assets/skins"
const _WALLET_LABEL_DEFAULT_FONT_SIZE: int = 20

const _SkinContainer = preload("res://src/menu/customization_menu/SkinContainer.tscn")

const _SKINS_ARRAY: Array = ["simple", "debug", "kawaii"]
var _main_scene_instance

func _ready():
	_refresh_wallet()

func _refresh_wallet() -> void:
	$WalletControl/CoinsLabel.text = str(PersistentUserWallet.get_coins())

func initialize(main_scene_instance) -> void:
	_main_scene_instance = main_scene_instance
	build_skin_list()

func scale_text(scale: float) -> void:
	ScalingHelper.scale_label_text(
		$WalletControl/CoinsLabel, _WALLET_LABEL_DEFAULT_FONT_SIZE, scale
	)
	for skin in $ScrollableContainerControl.get_content():
		skin.scale_text(scale)

func build_skin_list() -> void:
	$ScrollableContainerControl.clear_content()
	var skin_paths: Array = FileUtils.get_directories_list(SKINS_PATH)
	for path in skin_paths:
		var skin_container: SkinContainer = _SkinContainer.instance()
		skin_container.initialize(path)
		$ScrollableContainerControl.append_content(skin_container)

#TODO integrate
func _change_snake(skin: String) -> void:
	_main_scene_instance.play_button_click_sound()
	PersistentCustomizationSettings.set_snake_skin(skin)

func _change_field(skin: String) -> void:
	_main_scene_instance.play_button_click_sound()
	PersistentCustomizationSettings.set_field_skin(skin)

func _change_perks(skin: String) -> void:
	_main_scene_instance.play_button_click_sound()
	PersistentCustomizationSettings.set_perks_skin(skin)
