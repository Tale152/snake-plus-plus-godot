class_name WallTODO extends CollidableEntity

func _init(
		coordinates: Coordinates
	).(
		coordinates,
		WallCollisionStrategy.new()
	):
	pass

class WallCollisionStrategy extends CollisionStrategy:
	
	var _collision_result: CollisionResult = CollisionResult.new(false)
	
	func execute(snake_properties: SnakePropertiesTODO) -> CollisionResult:
		if !snake_properties.is_invincible():
			snake_properties.set_is_alive(false) 
		return _collision_result
