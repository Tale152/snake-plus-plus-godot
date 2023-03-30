class_name SnakeBodyPartTODO extends CollidableEntity

var _preceding_part_direction: int
var _following_part_direction: int

func _init(
		coordinates: Coordinates,
		preceding_part_direction: int,
		following_part_direction: int,
		collision_strategy: CollisionStrategy
	).(
		coordinates,
		collision_strategy
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
