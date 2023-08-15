class_name GameOverHelper extends Reference

var _is_challenge: bool
var _lose_conditions: GameConclusionTriggers
var _check_not_lost_strategy: FuncRef

func _init(is_challenge: bool, lose_conditions: GameConclusionTriggers):
	_is_challenge = is_challenge
	_lose_conditions = lose_conditions
	if is_challenge && _lose_conditions != null:
		_check_not_lost_strategy = funcref(self, "_check_not_lost_with_conditions")
	else:
		_check_not_lost_strategy = funcref(self, "_check_not_lost_base")

# called very often in game loop
func is_not_game_over(
	is_snake_alive: bool,
	elapsed_seconds: float,
	current_score: int,
	current_length: int
) -> bool:
	return is_snake_alive && _check_not_lost_strategy.call_func(
		elapsed_seconds, current_score, current_length
	)

func _check_not_lost_with_conditions(
	elapsed_seconds: float, current_score: int, current_length: int
) -> bool:
	return _lose_conditions.can_game_continue(
		elapsed_seconds, current_score, current_length
	)

func _check_not_lost_base(
	_elapsed_seconds: float, _current_score: int, _current_length: int
) -> bool:
	# does not check anything on purpose
	return true
