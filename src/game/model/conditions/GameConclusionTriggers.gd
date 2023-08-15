class_name GameConclusionTriggers extends Reference

var _time_trigger: float = -1
var _time_trigger_not_reached_strategy: FuncRef
var _score_trigger: int = -1
var _score_trigger_not_reached_strategy: FuncRef
var _length_trigger: int = -1
var _length_trigger_not_reached_strategy: FuncRef

func _init(game_conclusion_dictionary: Dictionary):
	var empty_strategy: FuncRef = funcref(self, "_is_trigger_not_reached_empty")
	var non_empty_strategy: FuncRef = funcref(self, "is_trigger_not_reached")
	if game_conclusion_dictionary.has("time"):
		_time_trigger = float(game_conclusion_dictionary.time)
		_time_trigger_not_reached_strategy = non_empty_strategy
	else:
		_time_trigger_not_reached_strategy = empty_strategy
	if game_conclusion_dictionary.has("score"):
		_score_trigger = int(game_conclusion_dictionary.score)
		_score_trigger_not_reached_strategy = non_empty_strategy
	else:
		_score_trigger_not_reached_strategy = empty_strategy
	if game_conclusion_dictionary.has("length"):
		_length_trigger = int(game_conclusion_dictionary.length)
		_length_trigger_not_reached_strategy = non_empty_strategy
	else:
		_length_trigger_not_reached_strategy = empty_strategy

func can_game_continue(time: float, score: int, length: int) -> bool:
	return(
		_time_trigger_not_reached_strategy.call_func(_time_trigger, time) &&
		_score_trigger_not_reached_strategy.call_func(_score_trigger, score) &&
		_length_trigger_not_reached_strategy.call_func(_length_trigger, length)
	)

func has_time_trigger() -> bool:
	return _time_trigger != -1

func get_time_trigger() -> float:
	return _time_trigger

func has_score_trigger() -> bool:
	return _score_trigger != -1

func get_score_trigger() -> int:
	return _score_trigger

func has_length_trigger() -> bool:
	return _length_trigger != -1

func get_length_trigger() -> int:
	return _length_trigger

func is_trigger_not_reached(trigger, value) -> bool:
	return value < trigger

func _is_trigger_not_reached_empty(_trigger, _value) -> bool:
	return true
