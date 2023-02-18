class_name GainCoin extends Reference

const GAIN_COIN_POINTS = 2000

func execute(
	_placement,
	_rules,
	_snake,
	_game	
) -> bool:
	var player: Player = _game.get_player()
	player.set_points(
		player.get_points() + GAIN_COIN_POINTS * player.get_multiplier()
	)
	return true
