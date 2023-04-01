class_name PerkStrategiesFactory extends Reference

var _true_coll_res: CollisionResult
var _false_coll_res: CollisionResult
var _effect_lifespan_seconds: float

func _init(
	true_collision_result: CollisionResult,
	false_collision_result: CollisionResult,
	effect_lifespan_seconds: float
):
	_true_coll_res = true_collision_result
	_false_coll_res = false_collision_result
	_effect_lifespan_seconds = effect_lifespan_seconds
	
func create_collision_strategy(type: int) -> CollisionStrategy:
	if(type == PerkType.APPLE()):
		return AppleStrategy.new(_true_coll_res, _false_coll_res)
	elif(type == PerkType.LEMON()):
		return LemonStrategy.new(_true_coll_res, _false_coll_res)
	elif(type == PerkType.CHERRY()):
		return CherryStrategy.new(_true_coll_res, _false_coll_res)
	elif(type == PerkType.STAR()):
		return StarStrategy.new(
			_true_coll_res, _false_coll_res, _effect_lifespan_seconds
		)
	elif(type == PerkType.ORANGE()):
		return OrangeStrategy.new(
			_true_coll_res, _false_coll_res, _effect_lifespan_seconds
		)
	# TODO add other strategies
	return null
