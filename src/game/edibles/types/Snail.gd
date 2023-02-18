class_name Snail extends Reference

const SNAIL_TOTAL_TIME_SECONDS = 5
const SNAIL_MULTIPLIER = 2

func execute(
	_placement,
	_rules,
	_snake,
	_game
) -> bool:
	var effect = EquippedEffect.new(
		EffectTypes.SNAIL(),
		SNAIL_TOTAL_TIME_SECONDS,
		SnailApplyStrategy.new(_snake),
		SnailRevokeStrategy.new(_snake)
	)
	_snake.add_effect(effect)
	return true

class SnailApplyStrategy:
	var _properties: SnakeProperties

	func _init(snake: Snake):
		_properties = snake.get_properties()

	func apply() -> void:
		_properties.set_speed_multiplier(
			_properties.get_speed_multiplier() * SNAIL_MULTIPLIER
		)
		

class SnailRevokeStrategy:
	var _properties: SnakeProperties

	func _init(snake: Snake):
		_properties = snake.get_properties()

	func revoke() -> void:
		_properties.set_speed_multiplier(
			_properties.get_speed_multiplier() / SNAIL_MULTIPLIER
		)
