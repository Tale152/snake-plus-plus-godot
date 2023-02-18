class_name EdibleRulesBuiler extends Reference

var _type: String
var _spawn_locations: Array
var _spawn_probability: float
var _life_span: float
var _max_instances: int

func set_type(type: String) -> EdibleRulesBuiler:
	_type = type
	return self

func set_spawn_locations(spawn_locations: Array) -> EdibleRulesBuiler:
	_spawn_locations = spawn_locations
	return self

func set_spawn_probability(spawn_probability: float) -> EdibleRulesBuiler:
	_spawn_probability = spawn_probability
	return self

func set_life_spawn(life_span: float) -> EdibleRulesBuiler:
	_life_span = life_span
	return self

func set_max_instances(max_instances: int) -> EdibleRulesBuiler:
	_max_instances = max_instances
	return self

func build() -> EdibleRules:
	var strategy = _get_strategy(_type)
	if strategy != null:
		return EdibleRules.new(
			_type,
			_spawn_locations,
			_spawn_probability,
			_life_span,
			_max_instances,
			strategy
		)
	else:
		return null

func _get_strategy(type: String):
	if type == EdibleTypes.APPLE():
		return Apple.new()
	elif type == EdibleTypes.BAD_APPLE():
		return BadApple.new()
	elif type == EdibleTypes.CHERRY():
		return Cherry.new()
	elif type == EdibleTypes.GAIN_COIN():
		return GainCoin.new()
	elif type == EdibleTypes.LOSS_COIN():
		return LossCoin.new()
	elif type == EdibleTypes.DOUBLE_SCORE():
		return DoubleScore.new()
	else:
		return null
