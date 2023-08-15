class_name HudUpdaterHelper extends Reference

var _lose_conditions: GameConclusionTriggers
var _update_hud_strategy: FuncRef
var _calculate_time_strategy: FuncRef
var _time_trigger: float
var _calculate_score_strategy: FuncRef
var _score_trigger: int
var _calculate_length_strategy: FuncRef
var _length_trigger: int
var base_calculation_strategy_only_instance = funcref(self, "_calculate_base")

func _init(lose_conditions: GameConclusionTriggers):
	_lose_conditions = lose_conditions
	if _lose_conditions != null:
		_update_hud_strategy = funcref(self, "_update_hud_with_lose_conditions")
		_calculate_time_strategy = base_calculation_strategy_only_instance
		_calculate_score_strategy = base_calculation_strategy_only_instance
		_calculate_length_strategy = base_calculation_strategy_only_instance
		if _lose_conditions.has_time_trigger():
			_time_trigger = _lose_conditions.get_time_trigger()
			_calculate_time_strategy = funcref(self, "_calculate_time_with_lose_condition")
		if _lose_conditions.has_score_trigger():
			_score_trigger = _lose_conditions.get_score_trigger()
			_calculate_score_strategy = funcref(self, "_calculate_score_with_lose_condition")
		if _lose_conditions.has_length_trigger():
			_length_trigger = _lose_conditions.get_length_trigger()
			_calculate_length_strategy = funcref(self, "_calculate_length_with_lose_condition")
	else:
		_update_hud_strategy = funcref(self, "_update_hud_base")

func update_hud(
	view, elapsed_seconds: float, current_score: int, current_length: int
) -> void:
	_update_hud_strategy.call_func(
		view, elapsed_seconds, current_score, current_length
	)

func _update_hud_base(
	view, elapsed_seconds: float, current_score: int, current_length: int
) -> void:
	view.update_hud(current_score, current_length, elapsed_seconds)

func _update_hud_with_lose_conditions(
	view, elapsed_seconds: float, current_score: int, current_length: int
) -> void:
	view.update_hud(
		_calculate_score_strategy.call_func(current_score),
		_calculate_length_strategy.call_func(current_length),
		_calculate_time_strategy.call_func(elapsed_seconds)
	)

func _calculate_base(value):
	return value

func _calculate_time_with_lose_condition(elapsed_seconds: float):
	var result = _time_trigger - elapsed_seconds + 1
	return result if result > 0 else 0

func _calculate_score_with_lose_condition(current_score: int):
	var result = _score_trigger - current_score
	return result if result > 0 else 0

func _calculate_length_with_lose_condition(current_length: int):
	var result = _length_trigger - current_length
	return result if result > 0 else 0
