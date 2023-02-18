class_name EquippedEffect extends Reference

var _type: String
var _elapsed_time: float = 0
var _total_time: float
var _apply_strategy: FuncRef
var _revoke_strategy: FuncRef

func _init(
	type: String,
	total_time: float,
	apply_strategy: FuncRef,
	revoke_strategy: FuncRef
):
	_type = type
	_total_time = total_time
	_apply_strategy = apply_strategy
	_revoke_strategy = revoke_strategy

func get_type() -> String:
	return _type

func apply_effect() -> void:
	_apply_strategy.call_func()

func revoke_effect() -> void:
	_revoke_strategy.call_func()

func tick(delta: float) -> bool:
	_elapsed_time += delta
	return _elapsed_time >= _total_time

func get_timer() -> EquippedEffectTimer:
	return EquippedEffectTimer.new(_type, _elapsed_time, _total_time)
