class_name EdibleBuilder extends Reference

# --- persisting values in a game ---
var _snake
var _game
var _visual_parameters: VisualParameters
var _rng = RandomNumberGenerator.new()

# --- specific values for instantiation ---
var _rules: EdibleRules = null
var _free_cells: Array = []

# I expect this arguments to be constants inside the same game,
# thus using only one instance of EdibleBuilder per game
func _init(snake, game, visual_parameters: VisualParameters):
	_snake = snake
	_game = game
	_visual_parameters = visual_parameters

func build_new() -> EdibleBuilder:
	_rules = null
	_free_cells = []
	return self

func set_rules(rules: EdibleRules) -> EdibleBuilder:
	_rules = rules
	return self

func set_free_cells(free_cells) -> EdibleBuilder:
	_free_cells = free_cells
	return self

func build():
	var placement = _get_valid_placement()
	if placement == null:
		return null
	var instance = Edible.new()
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
		_rng.randomize()
		return target_array[_rng.randi() % target_array.size()]
	else:
		return null
