class_name ChallengeRecordHelper extends Reference

var _ratings_container: GameRatingTriggerConditionsContainer

func set_ratings_container(
	ratings_container: GameRatingTriggerConditionsContainer
) -> void:
	_ratings_container = ratings_container

func save_new_record(
	uuid: String, stage_result: StageResult
) -> void:
	var stars_reached: int = 0
	if _are_star_rating_conditions_satisfied(
		_ratings_container.get_one_star_game_rating_trigger_conditions(),
		stage_result
	):
		stars_reached = 1
		if _are_star_rating_conditions_satisfied(
			_ratings_container.get_two_stars_game_rating_trigger_conditions(),
			stage_result
		):
			stars_reached = 2
			if _are_star_rating_conditions_satisfied(
				_ratings_container.get_three_stars_game_rating_trigger_conditions(),
				stage_result
			):
				stars_reached = 3
	print("stars reached: " + str(stars_reached))
	# TODO if stars reached > 0 get the persisted result
	# if it does not exist then save this
	# else check if it is greater than the previous one and, if so, save it

func _are_star_rating_conditions_satisfied(
	conditions: GameRatingTriggerConditions, stage_result: StageResult
) -> bool:
	return conditions.are_conditions_satisfied(
		stage_result.get_score(), stage_result.get_time(), stage_result.get_length()
	)
