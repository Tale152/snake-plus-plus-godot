class_name AppleStrategy extends CollisionStrategy
	
func execute(model: GameModel) -> CollisionResult:
	var snake_properties: SnakeProperties = model.get_snake_properties()
	if snake_properties.is_intangible():
		return CollisionResult.new(false)
	else:
		snake_properties.set_potential_length(
			snake_properties.get_potential_length() + 1
		)
		return CollisionResult.new(true)
