class_name Orange extends Reference

const ORANGE_TOTAL_TIME_SECONDS = 5
const ORANGE_MULTIPLIER = 2

func execute(
	_placement,
	_rules,
	_snake,
	_game
) -> bool:
	var effect = EquippedEffect.new(
		EffectTypes.ORANGE(),
		ORANGE_TOTAL_TIME_SECONDS,
		OrangeApplyStrategy.new(_game.get_player()),
		OrangeRevokeStrategy.new(_game.get_player())
	)
	_snake.add_effect(effect)
	return true

class OrangeApplyStrategy:
	var _player: Player

	func _init(player: Player):
		_player = player

	func apply() -> void:
		_player.set_multiplier(
			_player.get_multiplier() * ORANGE_MULTIPLIER
		)
		

class OrangeRevokeStrategy:
	var _player: Player

	func _init(player: Player):
		_player = player

	func revoke() -> void:
		_player.set_multiplier(
			# warning-ignore:integer_division
			_player.get_multiplier() / ORANGE_MULTIPLIER
		)
