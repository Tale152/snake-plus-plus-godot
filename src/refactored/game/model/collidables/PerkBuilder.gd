class_name PerkBuilder extends Reference

var _type: int
var _coordinates: Coordinates
var _lifespan_seconds: float = -1.0

func set_type(perk_type: int) -> PerkBuilder:
	_type = perk_type
	return self

func set_coordinates(coordinates: Coordinates) -> PerkBuilder:
	_coordinates = coordinates
	return self

func set_lifespan_seconds(lifespan_seconds: float) -> PerkBuilder:
	_lifespan_seconds = lifespan_seconds
	return self

func build() -> Perk:
	return Perk.new(
		_type,
		_coordinates,
		_get_collision_strategy(_type),
		_lifespan_seconds
	)

func _get_collision_strategy(type: int) -> CollisionStrategy:
	if type == PerkType.APPLE(): return AppleStrategy.new()
	return null
	# extend as new Perks get created
