class_name Avocado extends Reference

const AVOCADO_TOTAL_TIME_SECONDS = 5
const AVOCADO_MULTIPLIER = 10

func execute(
	_placement,
	_rules,
	_snake,
	_game
) -> bool:
	var effect = EquippedEffect.new(
		EffectTypes.AVOCADO(),
		AVOCADO_TOTAL_TIME_SECONDS,
		AvocadoApplyStrategy.new(_game.get_player()),
		AvocadoRevokeStrategy.new(_game.get_player())
	)
	_snake.add_effect(effect)
	return true

class AvocadoApplyStrategy:
	var _player: Player

	func _init(player: Player):
		_player = player

	func apply() -> void:
		_player.set_multiplier(
			_player.get_multiplier() * AVOCADO_MULTIPLIER
		)
		

class AvocadoRevokeStrategy:
	var _player: Player

	func _init(player: Player):
		_player = player

	func revoke() -> void:
		_player.set_multiplier(
			# warning-ignore:integer_division
			_player.get_multiplier() / AVOCADO_MULTIPLIER
		)
