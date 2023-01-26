extends Node

const CELL_PIXEL_SIZE = 20

const FIELD_HEIGHT = 20
const FIELD_WIDTH = 10
var FIELD_SIZE = FieldSize.new(FIELD_HEIGHT, FIELD_WIDTH)
var SNAKE_SPAWN_POINT = ImmutablePoint.new(0,0)
var SNAKE_INITIAL_DIRECTION = Directions.get_right()
const SNAKE_BASE_DELTA_SECONDS = 0.3
const SNAKE_SPEEDUP_FACTOR = 0.98
var APPLE_RULES = EdibleRulesBuiler.new() \
	.set_max_instances(5) \
	.set_spawn_locations([]) \
	.set_life_spawn(-1) \
	.set_spawn_probability(1) \
	.set_type(EdibleTypes.APPLE()) \
	.build()

var BAD_APPLE_RULES = EdibleRulesBuiler.new() \
	.set_max_instances(3) \
	.set_spawn_locations([]) \
	.set_life_spawn(-1) \
	.set_spawn_probability(1) \
	.set_type(EdibleTypes.BAD_APPLE()) \
	.build()

func _init():
	var description = StageDescriptionBuilder.new() \
		.set_field_size(FIELD_SIZE) \
		.set_snake_spawn_point(SNAKE_SPAWN_POINT) \
		.set_snake_initial_direction(SNAKE_INITIAL_DIRECTION) \
		.set_snake_base_delta_seconds(SNAKE_BASE_DELTA_SECONDS) \
		.set_snake_speedup_factor(SNAKE_SPEEDUP_FACTOR) \
		.add_edible_rules(APPLE_RULES) \
		.add_edible_rules(BAD_APPLE_RULES) \
		.build()
	
	if description == null:
		print("Description is null")
	else:
		var visual_parameters = VisualParametersBuilder.new() \
			.set_cell_pixels_size(CELL_PIXEL_SIZE) \
			.set_snake_skin_path("res://assets/skins/simple/snake") \
			.add_edible_sprite(EdibleSprite.new("res://assets/skins/simple/edibles", "Apple")) \
			.add_edible_sprite(EdibleSprite.new("res://assets/skins/simple/edibles", "BadApple")) \
			.build()
		add_child(Game.new(description, visual_parameters))
