class_name Chili extends Reference

const CHILI_TOTAL_TIME_SECONDS = 5
const CHILI_MULTIPLIER = 0.5

func execute(
	_placement,
	_rules,
	_snake,
	_game
) -> bool:
	var effect = EquippedEffect.new(
		EffectTypes.CHILI(),
		CHILI_TOTAL_TIME_SECONDS,
		ChiliApplyStrategy.new(_snake),
		ChiliRevokeStrategy.new(_snake)
	)
	_snake.add_effect(effect)
	return true

class ChiliApplyStrategy:
	var _properties: SnakeProperties

	func _init(snake: Snake):
		_properties = snake.get_properties()

	func apply() -> void:
		_properties.set_speed_multiplier(
			_properties.get_speed_multiplier() * CHILI_MULTIPLIER
		)

class ChiliRevokeStrategy:
	var _properties: SnakeProperties

	func _init(snake: Snake):
		_properties = snake.get_properties()

	func revoke() -> void:
		_properties.set_speed_multiplier(
			_properties.get_speed_multiplier() / CHILI_MULTIPLIER
		)
