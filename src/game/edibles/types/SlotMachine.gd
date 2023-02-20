class_name SlotMachine extends Reference

const NORMAL_WIN_PROBABILITY_TRESHOLD = 0.9
const JACKPOT_PROBABILITY_TRESHOLD = 0.995
const FEE = 10000
const NORMAL_WIN_PRICE = 15000
const JACKPOT_PRICE = 1000000

var rng = RandomNumberGenerator.new()
func _init():
	rng.randomize()

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
		var rand_val = rng.randf()
		player.set_points(
			player.get_points() - current_fee
		)
		if rand_val >= JACKPOT_PROBABILITY_TRESHOLD:
			player.set_points(
				player.get_points() + JACKPOT_PRICE * multiplier
			)
		elif rand_val >= NORMAL_WIN_PROBABILITY_TRESHOLD:
			player.set_points(
				player.get_points() + NORMAL_WIN_PRICE * multiplier
			)
	return true
