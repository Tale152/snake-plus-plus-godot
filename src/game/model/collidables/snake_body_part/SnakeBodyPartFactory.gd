class_name SnakeBodyPartFactory extends Reference

# I need just one instance of SnakeBodyPartCollisionStrategy to be used
# in every SnakeBodyPart
var _collision_strategy: CollisionStrategy = SnakeBodyPartCollisionStrategy.new()

func create_new(
	coordinates: Coordinates,
	preceding_part_direction: int,
	following_part_direction: int
) -> SnakeBodyPartTODO:
	return SnakeBodyPartTODO.new(
		coordinates,
		preceding_part_direction,
		following_part_direction,
		_collision_strategy
	)
