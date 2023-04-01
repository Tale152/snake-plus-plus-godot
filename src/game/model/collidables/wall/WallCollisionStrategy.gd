class_name WallCollisionStrategy extends CollisionStrategy
	
var _collision_result: CollisionResult = CollisionResult.new(false)

func execute(model: GameModel) -> CollisionResult:
	if !model.get_snake_properties().is_invincible():
		model.get_snake_properties().set_is_alive(false) 
	return _collision_result
