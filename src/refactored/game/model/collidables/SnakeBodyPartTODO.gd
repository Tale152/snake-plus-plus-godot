class_name SnakeBodyPartTODO extends CollidableEntity

var _preceding_part_direction: int
var _following_part_direction: int

func _init(
		coordinates: Coordinates,
		preceding_part_direction: int,
		following_part_direction: int
	).(
		coordinates,
		SnakeBodyPartCollisionStrategy.new()
	):
	_preceding_part_direction = preceding_part_direction
	_following_part_direction = following_part_direction

func get_preceding_part_direction() -> int:
	return _preceding_part_direction

func set_preceding_part_direction(preceding_part_direction: int) -> void:
	_preceding_part_direction = preceding_part_direction

func get_following_part_direction() -> int:
	return _following_part_direction

func set_following_part_direction(following_part_direction: int) -> void:
	_following_part_direction = following_part_direction

class SnakeBodyPartCollisionStrategy extends CollisionStrategy:
	
	var _collision_result: CollisionResult = CollisionResult.new(false)
	
	func execute(snake_properties: SnakePropertiesTODO) -> CollisionResult:
		if !snake_properties.is_invincible():
			snake_properties.set_is_alive(false) 
		return _collision_result
