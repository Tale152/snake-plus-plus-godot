class_name SkinContainer extends Control

const _STAGE_INFO_FILE_NAME: String = "stage_info.json"
const _SKIN_FILE_NAME: String = "body_STRAIGHT_UP"
const _SKIN_NAME_LABEL_DEFAULT_FONT_SIZE: int = 20
const _SKIN_NAME_LABEL_DEFAULT_OUTLINE_SIZE: int = 2
const _DEFAULT_MIN_WIDTH: int = 282
const _DEFAULT_MIN_HEIGHT: int = 90

var _stage_info: Dictionary
var _on_update_strategy: FuncRef

func initialize(skin_path: String, on_update_strategy: FuncRef) -> void:
	_stage_info = FileUtils.get_json_file_content(skin_path + "/" + _STAGE_INFO_FILE_NAME)
	$SkinNameLabel.text = _get_skin_name()
	refresh_button()
	_init_sprite(skin_path)
	_on_update_strategy = on_update_strategy

func scale_text(scale: float) -> void:
	self.rect_min_size = Vector2(
		_DEFAULT_MIN_WIDTH * scale,
		_DEFAULT_MIN_HEIGHT * scale
	)
	ScalingHelper.scale_text_and_outline(
		$SkinNameLabel,
		_SKIN_NAME_LABEL_DEFAULT_FONT_SIZE,
		_SKIN_NAME_LABEL_DEFAULT_OUTLINE_SIZE,
		scale
	)

func _get_skin_name() -> String:
	if !_stage_info.has("name"): return "STRUCTURE ERROR"
	var name_dictionary: Dictionary = _stage_info.name
	if name_dictionary.has(PersistentUserSettings.get_language()):
		return name_dictionary[PersistentUserSettings.get_language()]
	else:
		return "LOCALIZATION ERROR"

func refresh_button() -> void:
	if !PersistentCustomizationSettings.is_unlocked(_stage_info.uuid):
		$EquipButtonContainerControl.visible = false
		$BuyButtonContainerControl.visible = true
		var affordable: bool = false
		if _stage_info.cost.currency == "coins":
			affordable = PersistentUserWallet.get_coins() >= _stage_info.cost.value
		else:
			print("SkinContainer currency error (not coins for " + _stage_info.uuid + ")")
		$BuyButtonContainerControl/BuyButtonTextureButton.disabled = !affordable
		$BuyButtonContainerControl/BuyButtonLabel.text = str(_stage_info.cost.value)
	else:
		$EquipButtonContainerControl.visible = true
		$BuyButtonContainerControl.visible = false
		if PersistentCustomizationSettings.get_selected_skin_uuid() == _stage_info.uuid:
			$EquipButtonContainerControl/EquipButtonTextureButton.disabled = true
			$EquipButtonContainerControl/EquipButtonLabel.text = TranslationsManager.get_localized_string(TranslationsManager.IN_USE)
		else:
			$EquipButtonContainerControl/EquipButtonTextureButton.disabled = false
			$EquipButtonContainerControl/EquipButtonLabel.text = TranslationsManager.get_localized_string(TranslationsManager.EQUIP)

func _init_sprite(skin_path: String) -> void:
	$SpriteTextureButton.texture_normal = load(skin_path + "/customization_texture.tres")	

func _on_BuyButtonTextureButton_pressed():
	PersistentCustomizationSettings.unlock(_stage_info.uuid)
	PersistentUserWallet.subtract_coins(_stage_info.cost.value)
	_on_update_strategy.call_func()

func _on_EquipButtonTextureButton_pressed():
	PersistentCustomizationSettings.set_selected_skin_uuid(_stage_info.uuid)
	_on_update_strategy.call_func()
