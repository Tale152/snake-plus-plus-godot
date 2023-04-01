class_name ParsedStage extends Reference

var _stage: Dictionary

func _init(stage: Dictionary):
	_stage = stage

func get_field_width() -> int:
	return int(_stage.field.size[0])

func get_field_height() -> int:
	return int(_stage.field.size[1])

func get_walls_points() -> Array:
	var res: Array = []
	for wall in _stage.field.walls:
		res.push_back(Vector2(int(wall[0]), int(wall[1])))
	return res

func get_snake_spawn_point() -> Vector2:
	return Vector2(int(_stage.snake.spawn[0]), int(_stage.snake.spawn[1]))

func get_snake_initial_direction() -> int:
	return int(_stage.snake.direction)

func get_perks_rules() -> Array:
	var res: Array = []
	for perk in _stage.perks:
		var spawn_locations: Array = []
		if perk.has("spawn_locations"):
			for location in perk.spawn_locations:
				spawn_locations.push_back(Vector2(int(location[0]), int(location[1])))
		res.push_back(ParsedPerkRules.new(
			perk.type,
			spawn_locations,
			1 if !perk.has("spawn_probability") else perk.spawn_probability,
			-1 if !perk.has("lifespan") else perk.lifespan,
			perk.max_instances
		))
	return res
