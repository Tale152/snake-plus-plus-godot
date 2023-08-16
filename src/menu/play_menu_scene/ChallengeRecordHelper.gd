class_name ChallengeRecordHelper extends Reference

var _ratings_container: GameRatingTriggerConditionsContainer
var _stages_data: Dictionary

func _init(stages_data: Dictionary):
	_stages_data = stages_data

func set_ratings_container(
	ratings_container: GameRatingTriggerConditionsContainer
) -> void:
	_ratings_container = ratings_container

func save_new_record(
	uuid: String, stage_result: StageResult
) -> void:
	var persisted_stars = _stages_data[uuid].get_stars()
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
	if stars_reached > persisted_stars:
		PersistentStagesData.set_new_challenge_stars(uuid, stars_reached)
		_stages_data = PersistentStagesData.get_stages()
		# stage completed for the first time since persisted_stars was 0 before
		# but stars_reached is greater
		if persisted_stars == 0:
			var stages_unlocked: int = StagesHelper.new().unlock_stages()
			# TODO show something if stages_unlocked > 0

func _are_star_rating_conditions_satisfied(
	conditions: GameRatingTriggerConditions, stage_result: StageResult
) -> bool:
	return conditions.are_conditions_satisfied(
		stage_result.get_score(), stage_result.get_time(), stage_result.get_length()
	)
