class_name EquippedEffectTODO extends Reference

var _type: int
var _effect_strategy: EffectStrategy
var _expire_timer: ExpireTimer

func _init(
	effect_type: int,
	effect_strategy: EffectStrategy,
	lifespan_seconds: float
):
	_type = effect_type
	_effect_strategy = effect_strategy
	_expire_timer = ExpireTimer.new(lifespan_seconds)

func get_type() -> int: return _type

func get_expire_timer() -> ExpireTimer: return _expire_timer

func apply_effect(snake_properties: SnakePropertiesTODO) -> void:
	_effect_strategy.execute_apply_effect(snake_properties)

func revoke_effect(snake_properties: SnakePropertiesTODO) -> void:
	_effect_strategy.execute_revoke_effect(snake_properties)
