class_name InstantaneousEdiblesBuilder extends Reference

# --- preloading instantaneous edibles scenes ---
const Apple = preload("res://src/game/edibles/instantaneous/Apple.tscn")
const BadApple = preload("res://src/game/edibles/instantaneous/BadApple.tscn")

# --- persisting values in a game ---
var _snake
var _game
var _visual_parameters: VisualParameters
var _rng = RandomNumberGenerator.new()

# --- specific values for instantiation ---
var _rules: InstantaneousEdibleRules = null
var _free_cells: Array = []

# I expect this arguments to be constants inside the same game,
# thus using only one instance of InstantaneousEdiblesBuilder per game
func _init(snake, game, visual_parameters: VisualParameters):
	_snake = snake
	_game = game
	_visual_parameters = visual_parameters

func build_new() -> InstantaneousEdiblesBuilder:
	_rules = null
	_free_cells = []
	return self

func set_rules(rules: InstantaneousEdibleRules) -> InstantaneousEdiblesBuilder:
	_rules = rules
	return self

func set_free_cells(free_cells) -> InstantaneousEdiblesBuilder:
	_free_cells = free_cells
	return self

func build():
	var placement = _get_valid_placement()
	if placement == null:
		return null
	var instance = _get_selected_edible(_rules.get_type())
	instance.spawn(
		placement,
		_rules,
		_snake,
		_game,
		_visual_parameters
	)
	return instance

func _get_valid_placement() -> ImmutablePoint:
	var target_array = _free_cells
	if _rules.get_spawn_locations().size() != 0:
		# only spawns in specific points
		target_array = []
		for l in _rules.get_spawn_locations():
			if ImmutablePoint.get_point_index_in_array(_free_cells, l) != -1:
				target_array.push_back(l)
	if target_array.size() > 0:
		return target_array[_rng.randomize().randi() % target_array.size()]
	else:
		return null

# Expand everytime a new instantaneous edible is implemented
func _get_selected_edible(type: String):
	if type == InstantaneousEdiblesTypes.APPLE():
		return Apple.instance()
	elif type == InstantaneousEdiblesTypes.BAD_APPLE():
		return BadApple.instance()
