class_name StagePreludeArcadeContent extends Control

const HIGHEST_SCORE_TITLE_DEFAULT_FONT_SIZE: int = 16
const HIGHEST_SCORE_TITLE_DEFAULT_OUTLINE_SIZE: int = 2
const NO_RESULTS_YET_DEFAULT_FONT_SIZE: int = 20
const NO_RESULTS_YET_DEFAULT_OUTLINE_SIZE: int = 2

func initialize(uuid: String) -> void:
	$HighestScoreContainerControl/MaxLengthReachedLabel.text = TranslationsManager.get_localized_string(
		TranslationsManager.MAX_LENGTH_REACHED
	) + " :"
	var stage_data: StageData = PersistentStagesData.get_stages()[uuid]
	var best_score: StageResult
	if PersistentPlaySettings.is_pro_difficulty():
		best_score = stage_data.get_pro_record()
	elif PersistentPlaySettings.is_regular_difficulty():
		best_score = stage_data.get_regular_record()
	if best_score != null:
		$HighestScoreContainerControl/ParametersInfoControl.visible = true
		$HighestScoreContainerControl/NoResultYetLabel.visible = false
		$HighestScoreContainerControl/ParametersInfoControl.set_snake(ParametersInfo.EQUALS, str(best_score.get_length()))
		$HighestScoreContainerControl/ParametersInfoControl.set_score(ParametersInfo.EQUALS, str(best_score.get_score()))
		$HighestScoreContainerControl/ParametersInfoControl.set_time(ParametersInfo.EQUALS, TimeUtils.seconds_to_minutes_seconds(best_score.get_time()))
	else:
		$HighestScoreContainerControl/ParametersInfoControl.visible = false
		$HighestScoreContainerControl/NoResultYetLabel.visible = true
		$HighestScoreContainerControl/NoResultYetLabel.text = TranslationsManager.get_localized_string(
			TranslationsManager.NO_RESULTS_YET
		)

func scale_text(scale: float) -> void:
	ScalingHelper.scale_text_and_outline(
		$HighestScoreContainerControl/MaxLengthReachedLabel,
		HIGHEST_SCORE_TITLE_DEFAULT_FONT_SIZE,
		HIGHEST_SCORE_TITLE_DEFAULT_OUTLINE_SIZE,
		scale
	)
	ScalingHelper.scale_text_and_outline(
		$HighestScoreContainerControl/NoResultYetLabel,
		NO_RESULTS_YET_DEFAULT_FONT_SIZE,
		NO_RESULTS_YET_DEFAULT_OUTLINE_SIZE,
		scale
	)
