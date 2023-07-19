class_name GameConclusionTriggers extends Reference

var _time_trigger: float = -1
var _time_trigger_reached_strategy: FuncRef
var _score_trigger: int = -1
var _score_trigger_reached_strategy: FuncRef
var _length_trigger: int = -1
var _length_trigger_reached_strategy: FuncRef
var _perk_triggers: Array = []
var _perk_triggers_reached_strategy: FuncRef = funcref(self, "_are_perk_triggers_reached_empty")

func _init(game_conclusion_dictionary: Dictionary):
	var empty_trigger_reached_strategy: FuncRef = funcref(self, "_is_trigger_reached_empty")
	var non_empty_trigger_reached_strategy: FuncRef = funcref(self, "_is_trigger_reached")
	if game_conclusion_dictionary.has("time"):
		_time_trigger = float(game_conclusion_dictionary.time)
		_time_trigger_reached_strategy = non_empty_trigger_reached_strategy
	else:
		_time_trigger_reached_strategy = empty_trigger_reached_strategy
	if game_conclusion_dictionary.has("score"):
		_score_trigger = int(game_conclusion_dictionary.score)
		_score_trigger_reached_strategy = non_empty_trigger_reached_strategy
	else:
		_score_trigger_reached_strategy = empty_trigger_reached_strategy
	if game_conclusion_dictionary.has("length"):
		_length_trigger = int(game_conclusion_dictionary.length)
		_length_trigger_reached_strategy = non_empty_trigger_reached_strategy
	else:
		_length_trigger_reached_strategy = empty_trigger_reached_strategy
	if game_conclusion_dictionary.has("perks"):
		_perk_triggers_reached_strategy = funcref(self, "_are_perk_triggers_reached")
		for perk in game_conclusion_dictionary.perks:
			_perk_triggers.push_back(PerkGameConclusionTrigger.new(
				PerkType.get_perk_type_int(str(perk[0])),
				int(perk[1])
			))

func is_game_conclusion_reached(
	time: float, score: int, length: int, perk_collisions_trackers: Array
) -> bool:
	return(
		_time_trigger_reached_strategy.call_func(_time_trigger, time) &&
		_score_trigger_reached_strategy.call_func(_score_trigger, score) &&
		_length_trigger_reached_strategy.call_func(_length_trigger, length) &&
		_perk_triggers_reached_strategy.call_func(_perk_triggers, perk_collisions_trackers)
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

func has_perks_triggers() -> bool:
	return _perk_triggers.size() > 0

func get_perks_triggers() -> Array:
	return _perk_triggers

func _is_trigger_reached(trigger, value) -> bool:
	return value >= trigger

func _is_trigger_reached_empty(_trigger, _value) -> bool:
	return true

func _are_perk_triggers_reached(perk_triggers: Array, perk_collision_trackers: Array) -> bool:
	return true

func _are_perk_triggers_reached_empty(_perk_triggers: Array, _perk_collision_trackers: Array) -> bool:
	return true
