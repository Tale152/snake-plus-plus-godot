class_name GameRatingTriggerConditionsContainer extends Reference

var _one_star: GameRatingTriggerConditions
var _two_stars: GameRatingTriggerConditions
var _three_stars: GameRatingTriggerConditions

func _init(ratings_array: Array):
	for rating in ratings_array:
		var structured_rating: GameRatingTriggerConditions = GameRatingTriggerConditions.new(rating)
		if structured_rating.get_stars() == 1: _one_star = structured_rating
		elif structured_rating.get_stars() == 2: _two_stars = structured_rating
		else: _three_stars = structured_rating

func get_one_star_game_rating_trigger_conditions() -> GameRatingTriggerConditions:
	return _one_star

func get_two_stars_game_rating_trigger_conditions() -> GameRatingTriggerConditions:
	return _two_stars

func get_three_stars_game_rating_trigger_conditions() -> GameRatingTriggerConditions:
	return _three_stars
