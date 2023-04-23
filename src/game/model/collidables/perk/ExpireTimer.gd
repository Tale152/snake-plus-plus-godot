class_name ExpireTimer extends Reference

var _elapsed_seconds: float
var _lifespan_seconds: float
var _tick_strategy: FuncRef
var _has_expired_strategy: FuncRef
var _lifespan_strategy: FuncRef

func _init(lifespan_seconds: float = -1.0):
	_lifespan_seconds = lifespan_seconds
	_elapsed_seconds = -1.0 if _lifespan_seconds == -1.0 else 0.0
	if _lifespan_seconds == -1.0:
		_tick_strategy = funcref(self, "_tick_not_expirable")
		_has_expired_strategy = funcref(self, "_has_expired_not_expirable")
		_lifespan_strategy = funcref(self, "_lifespan_strategy_not_expirable")
	else:
		_tick_strategy = funcref(self, "_tick_expirable")
		_has_expired_strategy = funcref(self, "_has_expired_expirable")
		_lifespan_strategy = funcref(self, "_lifespan_strategy_expirable")

func _tick_not_expirable(_delta_seconds: float) -> void:
	pass

func _tick_expirable(delta_seconds: float) -> void:
	_elapsed_seconds += delta_seconds

func tick(delta_seconds: float) -> void:
	_tick_strategy.call_func(delta_seconds)

func can_expire() -> bool:
	return _lifespan_seconds != -1.0

func _has_expired_not_expirable() -> bool:
	return false

func _has_expired_expirable() -> bool:
	return _elapsed_seconds >= _lifespan_seconds

func has_expired() -> bool:
	return _has_expired_strategy.call_func()

func reset() -> void:
	if _lifespan_seconds != -1.0:
		_elapsed_seconds = 0.0

func _lifespan_strategy_not_expirable() -> float:
	return -1.0

func _lifespan_strategy_expirable() -> float:
	var percentage: float = 1 - (_elapsed_seconds / _lifespan_seconds)
	return 0.0 if percentage < 0.0 else percentage

func get_remaining_lifespan_percentage() -> float:
	return _lifespan_strategy.call_func()
