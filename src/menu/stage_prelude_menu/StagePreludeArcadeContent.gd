class_name StagePreludeArcadeContent extends Control

const BEST_RESULT_TITLE_DEFAULT_FONT_SIZE: int = 16
const BEST_RESULT_TITLE_DEFAULT_OUTLINE_SIZE: int = 2
const NO_RESULTS_YET_DEFAULT_FONT_SIZE: int = 20
const NO_RESULTS_YET_DEFAULT_OUTLINE_SIZE: int = 2

func initialize(uuid: String) -> void:
	$BestResultLengthContainerControl/BestResultLabel.text = TranslationsManager.get_localized_string(
		TranslationsManager.MAX_LENGTH_REACHED
	) + " :"
	$BestResultScoreContainerControl/BestResultLabel.text = TranslationsManager.get_localized_string(
		TranslationsManager.MAX_SCORE_REACHED
	) + " :"
	$BestResultSingleContainerControl/BestResultLabel.text = TranslationsManager.get_localized_string(
		TranslationsManager.BEST_SCORE_REACHED
	) + " :"
	var stage_data: StageData = PersistentStagesData.get_stages()[uuid]
	var best_length_result: StageResult
	var best_score_result: StageResult
	if PersistentPlaySettings.is_pro_difficulty():
		best_length_result = stage_data.get_pro_length_record()
		best_score_result = stage_data.get_pro_score_record()
	elif PersistentPlaySettings.is_regular_difficulty():
		best_length_result = stage_data.get_regular_length_record()
		best_score_result = stage_data.get_regular_score_record()
	if best_length_result == null && best_score_result == null:
		# no best result yet
		$BestResultLengthContainerControl.visible = false
		$BestResultScoreContainerControl.visible = false
		$BestResultSingleContainerControl.visible = true
		$BestResultSingleContainerControl/ParametersInfoControl.visible = false
		$BestResultSingleContainerControl/NoResultYetLabel.visible = true
		$BestResultSingleContainerControl/NoResultYetLabel.text = TranslationsManager.get_localized_string(
			TranslationsManager.NO_RESULTS_YET
		)
	elif best_length_result.equals_to(best_score_result):
		#same result
		$BestResultLengthContainerControl.visible = false
		$BestResultScoreContainerControl.visible = false
		$BestResultSingleContainerControl.visible = true
		$BestResultSingleContainerControl/ParametersInfoControl.visible = true
		$BestResultSingleContainerControl/NoResultYetLabel.visible = false
		$BestResultSingleContainerControl/ParametersInfoControl.set_snake(ParametersInfo.EQUALS, str(best_length_result.get_length()))
		$BestResultSingleContainerControl/ParametersInfoControl.set_score(ParametersInfo.EQUALS, str(best_length_result.get_score()))
		$BestResultSingleContainerControl/ParametersInfoControl.set_time(ParametersInfo.EQUALS, TimeUtils.seconds_to_minutes_seconds(best_length_result.get_time()))
	else:
		# two results
		$BestResultLengthContainerControl.visible = true
		$BestResultScoreContainerControl.visible = true
		$BestResultSingleContainerControl.visible = false
		$BestResultLengthContainerControl/ParametersInfoControl.set_snake(ParametersInfo.EQUALS, str(best_length_result.get_length()))
		$BestResultLengthContainerControl/ParametersInfoControl.set_score(ParametersInfo.EQUALS, str(best_length_result.get_score()))
		$BestResultLengthContainerControl/ParametersInfoControl.set_time(ParametersInfo.EQUALS, TimeUtils.seconds_to_minutes_seconds(best_length_result.get_time()))
		$BestResultScoreContainerControl/ParametersInfoControl.set_snake(ParametersInfo.EQUALS, str(best_score_result.get_length()))
		$BestResultScoreContainerControl/ParametersInfoControl.set_score(ParametersInfo.EQUALS, str(best_score_result.get_score()))
		$BestResultScoreContainerControl/ParametersInfoControl.set_time(ParametersInfo.EQUALS, TimeUtils.seconds_to_minutes_seconds(best_score_result.get_time()))

func scale_text(scale: float) -> void:
	ScalingHelper.scale_text_and_outline(
		$BestResultLengthContainerControl/BestResultLabel,
		BEST_RESULT_TITLE_DEFAULT_FONT_SIZE,
		BEST_RESULT_TITLE_DEFAULT_OUTLINE_SIZE,
		scale
	)
	ScalingHelper.scale_text_and_outline(
		$BestResultScoreContainerControl/BestResultLabel,
		BEST_RESULT_TITLE_DEFAULT_FONT_SIZE,
		BEST_RESULT_TITLE_DEFAULT_OUTLINE_SIZE,
		scale
	)
	ScalingHelper.scale_text_and_outline(
		$BestResultSingleContainerControl/NoResultYetLabel,
		NO_RESULTS_YET_DEFAULT_FONT_SIZE,
		NO_RESULTS_YET_DEFAULT_OUTLINE_SIZE,
		scale
	)
	ScalingHelper.scale_text_and_outline(
		$BestResultSingleContainerControl/BestResultLabel,
		BEST_RESULT_TITLE_DEFAULT_FONT_SIZE,
		BEST_RESULT_TITLE_DEFAULT_OUTLINE_SIZE,
		scale
	)
