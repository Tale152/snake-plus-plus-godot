class_name StagePrelude extends Control

var _ArcadeStageInfoFont = preload("res://src/menu/play_menu_scene/ArcadeStageInfoFont.tres")
var _ArcadeStageInfoButtonFont = preload("res://src/menu/play_menu_scene/ArcadeStageInfoButtonFont.tres")

var _data: MenuStageData
var _on_play_pressed: FuncRef
var _on_back_pressed: FuncRef

func initialize(
	data: MenuStageData,
	name: String,
	on_play_pressed: FuncRef,
	on_back_pressed: FuncRef
) -> void:
	_data = data
	$StageNameLabel.text = name
	var stage_data: StageData = PersistentStagesData.get_stages()[_data.get_uuid()]
	if stage_data.get_arcade_record() == null:
		$LongestSnakeGameDataLabel.text = TranslationsManager.get_localized_string(
			TranslationsManager.NO_RECORD
		)
		$HighestScoreGameDataLabel.text = TranslationsManager.get_localized_string(
			TranslationsManager.NO_RECORD
		)
	else:
		$LongestSnakeGameDataLabel.text = _get_record_string(
			stage_data.get_arcade_record().get_length_record(PersistentPlaySettings.get_difficulty())
		)
		$HighestScoreGameDataLabel.text = _get_record_string(
			stage_data.get_arcade_record().get_score_record(PersistentPlaySettings.get_difficulty())
		)
	if PersistentPlaySettings.get_difficulty() == PersistentPlaySettings.PRO:
		$StarsLabel.text = TranslationsManager.get_localized_string(
			TranslationsManager.STARS_OBTAINED
			) + ": " + str(stage_data.get_stars_pro())
	else:
		$StarsLabel.text = TranslationsManager.get_localized_string(
			TranslationsManager.STARS_OBTAINED
			) + ": " + str(stage_data.get_stars_regular())
	
	_on_play_pressed = on_play_pressed
	_on_back_pressed = on_back_pressed

func scale(scale: float) -> void:
	_ArcadeStageInfoFont.size = 16 * scale
	_ArcadeStageInfoButtonFont.size = 13 * scale

func _get_record_string(result: StageResult) -> String:
	if result == null:
		return TranslationsManager.get_localized_string(
			TranslationsManager.NO_RECORD
		)
	else:
		return str(
			_get_record_line(TranslationsManager.LENGTH, result.get_length()),
			"\n",
			_get_record_line(TranslationsManager.SCORE, result.get_score()),
			"\n",
			_get_record_line(TranslationsManager.TIME, result.get_time())
		)

func _get_record_line(field_name: String, value) -> String:
	return str(
		TranslationsManager.get_localized_string(field_name), ": ", value
	)

func _on_PlayButton_pressed():
	_on_play_pressed.call_func(_data)

func _on_BackButton_pressed():
	_on_back_pressed.call_func()
