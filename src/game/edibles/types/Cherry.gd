class_name Cherry extends Reference

const CHERRY_POINTS = 50

func execute(
	_placement,
	_rules,
	_snake,
	_game	
) -> bool:
	_snake.get_properties().set_potential_length(
		_snake.get_properties().get_potential_length() + 5
	)
	var player: Player = _game.get_player()
	player.set_points(
		player.get_points() + CHERRY_POINTS * player.get_multiplier()
	)
	return true
