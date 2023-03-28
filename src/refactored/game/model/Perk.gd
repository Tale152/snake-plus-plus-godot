class_name Perk extends CollidableEntity

var _perk_type: int
var _expire_timer: ExpireTimer

func _init(
	perk_type: int,
	coordinates: Coordinates,
	collision_strategy: CollisionStrategy,
	lifespan_seconds: float = -1.0
).(coordinates, collision_strategy):
	_perk_type = perk_type
	_expire_timer = ExpireTimer.new(lifespan_seconds)

func get_type() -> int: return _perk_type

func get_expire_timer() -> ExpireTimer: return _expire_timer
