extends Control

onready var _SummaryLabelFont = preload("res://src/menu/play_menu_scene/SummaryLabelFont.tres")

const _DEFAULT_FONT_SIZE: int = 13
const _ICON_DEFAULT_SIZE: int = 15
var _icon_size: int = _ICON_DEFAULT_SIZE

func _ready():
	update()

func scale_font(scale: float) -> void:
	_SummaryLabelFont.size = _get_int_font_size(_DEFAULT_FONT_SIZE, scale)
	_icon_size = _get_int_font_size(_ICON_DEFAULT_SIZE, scale)
	update()

func _get_int_font_size(default_value: int, scale: float) -> int:
	return int(floor(default_value * scale))

func update() -> void:
	if PersistentPlaySettings.get_mode() == PersistentPlaySettings.CHALLENGE:
		var stages_number: int = StagesHelper.new().list_stage_files().size()
		var total_stars: String = str(stages_number * 3)
		var obtained_stars: String = _get_obtained_stars()
		$SummaryRichLabel.bbcode_text = _create_text(
			obtained_stars + " / " + total_stars,
			"res://assets/icons/star.png",
			_icon_size
		)
	else:
		$SummaryRichLabel.bbcode_text = _create_text(
			_get_total_length_reached(),
			"res://assets/icons/snake_head.png",
			_icon_size
		)

func _create_text(text: String, image: String, size: int) -> String:
	return "[center]" + text + " [img=" + str(size) + "]" + image + "[/img][/center]"

func _get_obtained_stars() -> String:
	var stages_data: Dictionary = PersistentStagesData.get_stages()
	var is_regular: bool = PersistentPlaySettings.get_difficulty() == PersistentPlaySettings.REGULAR
	var total: int = 0
	for uuid in stages_data.keys():
		var data: StageData = stages_data[uuid]
		if is_regular && data.get_stars_regular() != null:
			total += data.get_stars_regular()
		elif data.get_stars_pro() != null:
			total += data.get_stars_pro()
	return str(total)

func _get_total_length_reached() -> String:
	var stages_data: Dictionary = PersistentStagesData.get_stages()
	var is_regular: bool = PersistentPlaySettings.get_difficulty() == PersistentPlaySettings.REGULAR
	var total: int = 0
	for uuid in stages_data.keys():
		var data: StageData = stages_data[uuid]
		if is_regular && data.get_regular_record() != null:
			total += data.get_regular_record().get_length()
		elif data.get_pro_record() != null:
			total += data.get_pro_record().get_length()
	return str(total)
