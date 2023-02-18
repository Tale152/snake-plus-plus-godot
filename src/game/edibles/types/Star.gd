class_name Star extends Reference

const STAR_TOTAL_TIME_SECONDS = 5

func execute(
	_placement,
	_rules,
	_snake,
	_game
) -> bool:
	var effect = EquippedEffect.new(
		EffectTypes.STAR(),
		STAR_TOTAL_TIME_SECONDS,
		StarApplyStrategy.new(_snake),
		StarRevokeStrategy.new(_snake)
	)
	_snake.add_effect(effect)
	return true

class StarApplyStrategy:
	var _properties: SnakeProperties

	func _init(snake: Snake):
		_properties = snake.get_properties()

	func apply() -> void:
		_properties.set_invincibility(true)

class StarRevokeStrategy:
	var _properties: SnakeProperties

	func _init(snake: Snake):
		_properties = snake.get_properties()

	func revoke() -> void:
		_properties.set_invincibility(false)
