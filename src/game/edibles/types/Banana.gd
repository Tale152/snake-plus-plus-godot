class_name Banana extends Reference

const BANANA_TOTAL_TIME_SECONDS = 5
const BANANA_MULTIPLIER = 5

func execute(
	_placement,
	_rules,
	_snake,
	_game
) -> bool:
	var effect = EquippedEffect.new(
		EffectTypes.BANANA(),
		BANANA_TOTAL_TIME_SECONDS,
		BananaApplyStrategy.new(_game.get_player()),
		BananaRevokeStrategy.new(_game.get_player())
	)
	_snake.add_effect(effect)
	return true

class BananaApplyStrategy:
	var _player: Player

	func _init(player: Player):
		_player = player

	func apply() -> void:
		_player.set_multiplier(
			_player.get_multiplier() * BANANA_MULTIPLIER
		)
		

class BananaRevokeStrategy:
	var _player: Player

	func _init(player: Player):
		_player = player

	func revoke() -> void:
		_player.set_multiplier(
			# warning-ignore:integer_division
			_player.get_multiplier() / BANANA_MULTIPLIER
		)
