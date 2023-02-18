class_name DoubleScore extends Reference

const DOUBLE_SCORE_TOTAL_TIME_SECONDS = 5
const DOUBLE_SCORE_MULTIPLIER = 2

func execute(
	_placement,
	_rules,
	_snake,
	_game
) -> bool:
	var effect = EquippedEffect.new(
		EffectTypes.DOUBLE_SCORE(),
		DOUBLE_SCORE_TOTAL_TIME_SECONDS,
		DoubleScoreApplyStrategy.new(_game.get_player()),
		DoubleScoreRevokeStrategy.new(_game.get_player())
	)
	_snake.add_effect(effect)
	return true

class DoubleScoreApplyStrategy:
	var _player: Player

	func _init(player: Player):
		_player = player

	func apply() -> void:
		_player.set_multiplier(
			_player.get_multiplier() * DOUBLE_SCORE_MULTIPLIER
		)
		

class DoubleScoreRevokeStrategy:
	var _player: Player

	func _init(player: Player):
		_player = player

	func revoke() -> void:
		_player.set_multiplier(
			# warning-ignore:integer_division
			_player.get_multiplier() / DOUBLE_SCORE_MULTIPLIER
		)
