class_name EquippedEffectTODO extends Reference
# meant to be used as abstract class 
var _type: int
var _expire_timer: ExpireTimer

func _init(
	effect_type: int,
	lifespan_seconds: float
):
	_type = effect_type
	_expire_timer = ExpireTimer.new(lifespan_seconds)

func get_type() -> int: return _type

func get_expire_timer() -> ExpireTimer: return _expire_timer

func apply_effect(snake_properties: SnakePropertiesTODO) -> void:
	# override on extending class
	pass

func revoke_effect(snake_properties: SnakePropertiesTODO) -> void:
	# override on extending class
	pass
