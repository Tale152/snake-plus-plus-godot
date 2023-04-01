class_name CollisionStrategy extends Reference
# is ment to be used as an Interface

func execute(model: GameModel) -> CollisionResult:
	push_error(
		"You called the execute function of CollisionStrategy, " + 
		"which is ment to be used as an interface"
	)
	return null
