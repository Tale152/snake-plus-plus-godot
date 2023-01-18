extends Node

const Game = preload("res://src/game/Game.tscn")
const DIRECTIONS = preload("res://src/enums/DirectionsEnum.gd").DIRECTIONS

const CELL_PIXEL_SIZE = 16

const FIELD_HEIGHT = 20
const FIELD_WIDTH = 10
var FIELD_SIZE = FieldSize.new(FIELD_HEIGHT, FIELD_WIDTH)
var SNAKE_SPAWN_POINT = ImmutablePoint.new(0,0)
const SNAKE_INITIAL_DIRECTION = DIRECTIONS.RIGHT
const SNAKE_BASE_DELTA_SECONDS = 0.3
const SNAKE_SPEEDUP_FACTOR = 0.99
var APPLE_RULES = EdibleRulesBuiler.new() \
	.set_max_instances(5) \
	.set_spawn_locations([]) \
	.set_life_spawn(-1) \
	.set_spawn_probability(1) \
	.set_type(EdibleTypes.APPLE()) \
	.build()

func _init():
	var apple_sprite: AnimatedSprite = AnimatedSprite.new()
	var image1: StreamTexture = load("res://assets/skins/simple/Apple.png")
	apple_sprite.frames = SpriteFrames.new()
	apple_sprite.frames.add_animation("default")
	apple_sprite.frames.add_frame("default", image1, 0)

	var description = StageDescriptionBuilder.new() \
		.set_field_size(FIELD_SIZE) \
		.set_snake_spawn_point(SNAKE_SPAWN_POINT) \
		.set_snake_initial_direction(SNAKE_INITIAL_DIRECTION) \
		.set_snake_base_delta_seconds(SNAKE_BASE_DELTA_SECONDS) \
		.set_snake_speedup_factor(SNAKE_SPEEDUP_FACTOR) \
		.add_edible_rules(APPLE_RULES) \
		.build()
	
	if description == null:
		print("Description is null")
	else:
		var game = Game.instance()
		game.setup(description, VisualParameters.new(CELL_PIXEL_SIZE, [["Apple", apple_sprite]]))
		add_child(game)
