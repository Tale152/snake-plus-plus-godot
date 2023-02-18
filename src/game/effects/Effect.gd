class_name Effect extends Reference

var _type: int
var _elapsed_time: float = 0
var _total_time: float
var _apply_strategy: FuncRef
var _revoke_strategy: FuncRef

func _init(
	type: int,
	total_time: float,
	apply_strategy: FuncRef,
	revoke_strategy: FuncRef
):
	_type = type
	_total_time = total_time
	_apply_strategy = apply_strategy
	_revoke_strategy = revoke_strategy

func get_type() -> int:
	return _type

func apply_effect(game) -> void:
	_apply_strategy.call_func(game)

func revoke_effect(game) -> void:
	_revoke_strategy.call_func(game)

func tick(delta: float) -> bool:
	_elapsed_time += delta
	return _elapsed_time >= _total_time

func get_timer() -> EffectTimer:
	return EffectTimer.new(_type, _elapsed_time, _total_time)
