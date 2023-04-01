class_name PerkStrategiesFactory extends Reference

static func create_collision_strategy(type: int) -> CollisionStrategy:
	if(type == PerkType.APPLE()): return AppleStrategy.new()
	# TODO add other strategies
	return null
