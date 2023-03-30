class_name PerkBuilder extends Reference

var _type: int
var _coordinates: Coordinates
var _lifespan_seconds: float = -1.0
var _collision_strategy: CollisionStrategy

func set_type(perk_type: int) -> PerkBuilder:
	_type = perk_type
	return self

func set_coordinates(coordinates: Coordinates) -> PerkBuilder:
	_coordinates = coordinates
	return self

func set_lifespan_seconds(lifespan_seconds: float) -> PerkBuilder:
	_lifespan_seconds = lifespan_seconds
	return self

func set_collision_strategy(
	collision_strategy: CollisionStrategy
) -> PerkBuilder:
	_collision_strategy = collision_strategy
	return self

func build() -> Perk:
	return Perk.new(
		_type,
		_coordinates,
		_collision_strategy,
		_lifespan_seconds
	)
