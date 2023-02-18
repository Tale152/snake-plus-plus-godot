class_name Diamond extends Reference

const DIAMOND_POINTS = 10000

func execute(
	_placement,
	_rules,
	_snake,
	_game	
) -> bool:
	var player: Player = _game.get_player()
	player.set_points(
		player.get_points() + DIAMOND_POINTS * player.get_multiplier()
	)
	return true
