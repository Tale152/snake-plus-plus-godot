class_name SkinContainer extends Control

const _STAGE_INFO_FILE_NAME: String = "stage_info.json"
const _SKIN_FILE_NAME: String = "body_STRAIGHT_UP"
const _SKIN_NAME_LABEL_DEFAULT_FONT_SIZE: int = 20
const _SKIN_NAME_LABEL_DEFAULT_OUTLINE_SIZE: int = 2
const _DEFAULT_MIN_WIDTH: int = 282
const _DEFAULT_MIN_HEIGHT: int = 90

func initialize(skin_path: String) -> void:
	var stage_info: Dictionary = FileUtils.get_json_file_content(skin_path + "/" + _STAGE_INFO_FILE_NAME)
	$SkinNameLabel.text = _get_skin_name(stage_info)
	_init_sprite(skin_path)
	print(stage_info.cost.value)

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

func _get_skin_name(stage_info: Dictionary) -> String:
	if !stage_info.has("name"): return "STRUCTURE ERROR"
	var name_dictionary: Dictionary = stage_info.name
	if name_dictionary.has(PersistentUserSettings.get_language()):
		return name_dictionary[PersistentUserSettings.get_language()]
	else:
		return "LOCALIZATION ERROR"

func _init_sprite(skin_path: String) -> void:
	$SpriteTextureButton.texture_normal = load(skin_path + "/customization_texture.tres")
