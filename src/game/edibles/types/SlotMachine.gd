class_name SlotMachine extends Reference

const SLOT_MACHINE_TOTAL_TIME_SECONDS = 5
const FEE = 10000

func execute(
	_placement,
	_rules,
	_snake,
	_game
) -> bool:
	var player: Player = _game.get_player()
	var multiplier = player.get_multiplier()
	var current_fee = FEE * multiplier
	if player.get_points() >= current_fee:
		player.set_points(
			player.get_points() - current_fee
		)
		var effect = EquippedEffect.new(
			EffectTypes.SLOT_MACHINE(),
			SLOT_MACHINE_TOTAL_TIME_SECONDS,
			SlotMachineApplyStrategy.new(),
			SlotMachineRevokeStrategy.new(_game.get_player(), multiplier)
		)
		_snake.add_effect(effect)
		return true
	else:
		return false
	

class SlotMachineApplyStrategy:
	func apply() -> void:
		pass


class SlotMachineRevokeStrategy:
	const NORMAL_WIN_PROBABILITY_TRESHOLD = 0.9
	const JACKPOT_PROBABILITY_TRESHOLD = 0.995
	const NORMAL_WIN_PRICE = 15000
	const JACKPOT_PRICE = 1000000

	var _player: Player
	var _multiplier: float
	var rng = RandomNumberGenerator.new()
	
	func _init(player: Player, multiplier: float):
		_player = player
		_multiplier = multiplier
		rng.randomize()

	func revoke() -> void:
		var rand_val = rng.randf()
		if rand_val >= JACKPOT_PROBABILITY_TRESHOLD:
			_player.set_points(
				_player.get_points() + JACKPOT_PRICE * _multiplier
			)
		elif rand_val >= NORMAL_WIN_PROBABILITY_TRESHOLD:
			_player.set_points(
				_player.get_points() + NORMAL_WIN_PRICE * _multiplier
			)
