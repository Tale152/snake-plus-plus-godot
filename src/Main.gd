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
var APPLE_RULES = InstantaneousEdibleRules.new(
	InstantaneousEdiblesTypes.APPLE(),
	[],
	1,
	-1,
	100
)

func _init():
	var description = StageDescriptionBuilder.new() \
		.set_field_size(FIELD_SIZE) \
		.set_snake_spawn_point(SNAKE_SPAWN_POINT) \
		.set_snake_initial_direction(SNAKE_INITIAL_DIRECTION) \
		.set_snake_base_delta_seconds(SNAKE_BASE_DELTA_SECONDS) \
		.set_snake_speedup_factor(SNAKE_SPEEDUP_FACTOR) \
		.add_instantaneous_edible_rules(APPLE_RULES) \
		.build()
	
	if description == null:
		print("Description is null")
	else:
		var game = Game.instance()
		game.setup(description, VisualParameters.new(CELL_PIXEL_SIZE))
		add_child(game)
