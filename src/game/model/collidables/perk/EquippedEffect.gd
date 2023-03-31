class_name EquippedEffect extends Reference
# meant to be used as abstract class

var _effect_type: int
var _expire_timer: ExpireTimer

func _init(
	effect_type: int,
	lifespan_seconds: float
):
	_effect_type = effect_type
	_expire_timer = ExpireTimer.new(lifespan_seconds)

func get_effect_type() -> int: return _effect_type

func get_expire_timer() -> ExpireTimer: return _expire_timer

func apply_effect(snake_properties: SnakeProperties) -> void:
	# override on extending class
	pass

func revoke_effect(snake_properties: SnakeProperties) -> void:
	# override on extending class
	pass
