class_name StagePreludeChallengeContent extends Control

func initialize(uuid: String, stage_path: String) -> void:
	var stage_data: StageData = PersistentStagesData.get_stages()[uuid]
	var stage_file_content: Dictionary = StagesHelper.new().read_file_as_json(stage_path)
	$ConditionsIndicatorControl.set_file_content(stage_file_content)
	if PersistentPlaySettings.is_pro_difficulty():
		$BestScoreStarsIndicatorControl.set_stars_number(stage_data.get_stars_pro())
	else:
		$BestScoreStarsIndicatorControl.set_stars_number(stage_data.get_stars_regular())

func scale_text(scale: float) -> void:
	$ConditionsIndicatorControl.scale_text(scale)
