class_name ConditionsIndicator extends Control

var _star_selection_1 = preload("res://assets/icons/star_selection_1.png")
var _star_selection_2 = preload("res://assets/icons/star_selection_2.png")
var _star_selection_3 = preload("res://assets/icons/star_selection_3.png")

var stars: int = 1
var _file_content: Dictionary

const REQUIREMENTS_LABEL_DEFAULT_SIZE: int = 20
const REQUIREMENTS_LABEL_DEFAULT_OUTLINE_SIZE: int = 2
const GAME_OVER_LABEL_DEFAULT_SIZE: int = 20
const GAME_OVER_LABEL_DEFAULT_OUTLINE_SIZE: int = 2

func _update_star_selection() -> void:
	var rating_requirements = _file_content["stage"]["conditions"]["win_ratings"]
	if stars == 1:
		$RequirementsContainerControl/StarsChooserControl/SelectedStarsTextureButton.texture_normal = _star_selection_1
		rating_requirements = rating_requirements[0]
	elif stars == 2:
		$RequirementsContainerControl/StarsChooserControl/SelectedStarsTextureButton.texture_normal = _star_selection_2
		rating_requirements = rating_requirements[1]
	else:
		$RequirementsContainerControl/StarsChooserControl/SelectedStarsTextureButton.texture_normal = _star_selection_3
		rating_requirements = rating_requirements[2]
	if rating_requirements != null:
		if rating_requirements.has("length"):
			$RequirementsContainerControl/RequirementsParametersInfoControl.set_snake(
				ParametersInfo.GREATER_THAN_EQUALS if rating_requirements["length"]["criteria"] == "reach" else ParametersInfo.LESS_THAN,
				str(rating_requirements["length"]["value"])
			)
		else:
			$RequirementsContainerControl/RequirementsParametersInfoControl.set_snake(
				ParametersInfo.LIKE, TranslationsManager.get_localized_string(TranslationsManager.NO_REQUIREMENT)
			)
		if rating_requirements.has("score"):
			$RequirementsContainerControl/RequirementsParametersInfoControl.set_score(
				ParametersInfo.GREATER_THAN_EQUALS if rating_requirements["score"]["criteria"] == "reach" else ParametersInfo.LESS_THAN,
				str(rating_requirements["score"]["value"])
			)
		else:
			$RequirementsContainerControl/RequirementsParametersInfoControl.set_score(
				ParametersInfo.LIKE, TranslationsManager.get_localized_string(TranslationsManager.NO_REQUIREMENT)
			)
		if rating_requirements.has("time"):
			$RequirementsContainerControl/RequirementsParametersInfoControl.set_time(
				ParametersInfo.GREATER_THAN_EQUALS if rating_requirements["time"]["criteria"] == "reach" else ParametersInfo.LESS_THAN,
				_seconds_to_minutes_seconds(rating_requirements["time"]["value"])
			)
		else:
			$RequirementsContainerControl/RequirementsParametersInfoControl.set_time(
				ParametersInfo.LIKE, TranslationsManager.get_localized_string(TranslationsManager.NO_REQUIREMENT)
			)

func scale_text(scale: float) -> void:
	$RequirementsContainerControl/RequirementsParametersInfoControl.scale_text(scale)
	$LoseConditionsContainerControl/GameOverParametersInfoControl.scale_text(scale)
	ScalingHelper.scale_label_text(
		$RequirementsContainerControl/RequirementsLabel, REQUIREMENTS_LABEL_DEFAULT_SIZE, scale
	)
	ScalingHelper.scale_label_outline(
		$RequirementsContainerControl/RequirementsLabel, REQUIREMENTS_LABEL_DEFAULT_OUTLINE_SIZE, scale
	)
	ScalingHelper.scale_label_text(
		$LoseConditionsContainerControl/GameOverLabel, GAME_OVER_LABEL_DEFAULT_SIZE, scale
	)
	ScalingHelper.scale_label_outline(
		$LoseConditionsContainerControl/GameOverLabel, GAME_OVER_LABEL_DEFAULT_OUTLINE_SIZE, scale
	)

func set_file_content(file_content: Dictionary) -> void:
	_file_content = file_content
	$RequirementsContainerControl/RequirementsLabel.text = TranslationsManager.get_localized_string(
		TranslationsManager.REQUIREMENTS
	) + " :"
	$LoseConditionsContainerControl/GameOverLabel.text = TranslationsManager.get_localized_string(
		TranslationsManager.GAME_OVER_IF
	) + " :"
	_update_star_selection()
	var lose_conditions: Dictionary = _file_content["stage"]["conditions"]["lose"]
	if lose_conditions != null:
		if lose_conditions.has("length"):
			$LoseConditionsContainerControl/GameOverParametersInfoControl.set_snake(
				ParametersInfo.EQUALS, str(lose_conditions["length"])
			)
		else:
			$LoseConditionsContainerControl/GameOverParametersInfoControl.set_snake(
				ParametersInfo.LIKE, TranslationsManager.get_localized_string(TranslationsManager.NO_TRIGGER)
			)
		if lose_conditions.has("score"):
			$LoseConditionsContainerControl/GameOverParametersInfoControl.set_score(
				ParametersInfo.EQUALS, str(lose_conditions["score"])
			)
		else:
			$LoseConditionsContainerControl/GameOverParametersInfoControl.set_score(
				ParametersInfo.LIKE, TranslationsManager.get_localized_string(TranslationsManager.NO_TRIGGER)
			)
		if lose_conditions.has("time"):
			$LoseConditionsContainerControl/GameOverParametersInfoControl.set_time(
				ParametersInfo.EQUALS, _seconds_to_minutes_seconds(lose_conditions["time"])
			)
		else:
			$LoseConditionsContainerControl/GameOverParametersInfoControl.set_time(
				ParametersInfo.LIKE, TranslationsManager.get_localized_string(TranslationsManager.NO_TRIGGER)
			)

func _seconds_to_minutes_seconds(seconds: float):
	return str(int(seconds / 60)) + ":" + str(int(seconds) % 60).pad_zeros(2)

func _on_StarsRightTextureButton_pressed():
	stars += 1
	if stars == 4: stars = 1
	_update_star_selection()

func _on_StarsLeftTextureButton_pressed():
	stars -= 1
	if stars == 0: stars = 3
	_update_star_selection()
