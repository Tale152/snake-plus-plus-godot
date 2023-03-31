class_name WallFactory extends Reference

# I need just one instance of WallCollisionStrategy to be used in every Wall
var _wall_collision_strategy: WallCollisionStrategy = WallCollisionStrategy.new()

func create_new(coord: Coordinates) -> Wall:
	return Wall.new(coord, _wall_collision_strategy)
