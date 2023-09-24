class_name StagePreludeContent extends Control

var _ArcadeStageInfoFont = preload("res://src/menu/stage_prelude_menu/ArcadeStageInfoFont.tres")
var _ArcadeStageInfoButtonFont = preload("res://src/menu/stage_prelude_menu/ArcadeStageInfoButtonFont.tres")

var STAGE_NAME_DEFAULT_FONT_SIZE: int = 20

var _data: MenuStageData
var _on_play_pressed: FuncRef

func initialize(
	data: MenuStageData,
	name: String,
	on_play_pressed: FuncRef
) -> void:
	_data = data
	$StageNameLabel.text = name
	var stage_data: StageData = PersistentStagesData.get_stages()[_data.get_uuid()]
	var stage_file_content: Dictionary = StagesHelper.new().read_file_as_json(data.get_stage_path())
	$ConditionsIndicatorControl.set_file_content(stage_file_content)
	if PersistentPlaySettings.get_difficulty() == PersistentPlaySettings.PRO:
		$BestScoreStarsIndicatorControl.set_stars_number(stage_data.get_stars_pro())
	else:
		$BestScoreStarsIndicatorControl.set_stars_number(stage_data.get_stars_regular())
	_on_play_pressed = on_play_pressed

func scale(scale: float) -> void:
	_ArcadeStageInfoFont.size = STAGE_NAME_DEFAULT_FONT_SIZE * scale
	_ArcadeStageInfoButtonFont.size = 20 * scale

func _on_PlayButton_pressed():
	_on_play_pressed.call_func(_data)
